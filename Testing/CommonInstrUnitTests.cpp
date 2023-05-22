#include "CppUnitTest.h"

#include "command_items.h"
#include "main_support.h"
#include "dprint.h"
#include "writer.h"
#include "reset.h"
#include "label.h"
#include "modtypes.h"

#define EA_MODE(a) ((a) << 3)
#define SUB_OPMODE(a) ((a) << 6)
#define SUB_REG(a) ((a) << 9)
#define SUBX_SIZE(a) ((a) << 6)

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTests
{
	TEST_CLASS(CommonInstructionUnitTests)
	{
	public:
		std::vector<char> testData;
		struct parse_state state;
		struct options opt;
		std::unique_ptr<BigEndianStream> stream;
		const wchar_t* subtestName;

		TEST_METHOD_INITIALIZE(init)
		{
			testData.clear();
			state = {};
			stream = nullptr;
			state.Pass = 2;
			state.opt = &opt;
			opt.modHeader = std::make_unique<module_header>();
			opt.IsROF = false;
			subtestName = nullptr;
			opt.modHeader->type = MT_PROGRAM;
			reset();
		}

		void pushWord(uint16_t word)
		{
			uint8_t high = static_cast<uint8_t>(word >> 8);
			uint8_t low = static_cast<uint8_t>(word);
			testData.push_back(high);
			testData.push_back(low);
		}

		void runTest(const char* expectedMneumonic, const char* expectedParams)
		{
			stream = std::make_unique<BigEndianStream>(std::move(testData));
			state.Module = stream.get();

			struct cmd_items instr;
			Assert::IsTrue(get_asmcmd(&instr, &state), subtestName);
			Assert::AreEqual(expectedMneumonic, instr.mnem, subtestName);
			std::string params;
			if (instr.useNewParams)
			{
				params = instr.renderNewParams();
			}
			else
			{
				params = instr.params;
			}
			Assert::AreEqual(expectedParams, params.c_str(), subtestName);
		}

		void runFailTest()
		{
			stream = std::make_unique<BigEndianStream>(std::move(testData));
			state.Module = stream.get();

			struct cmd_items instr;
			Assert::IsFalse(get_asmcmd(&instr, &state), subtestName);
		}

		// Tests all of the opcodes that begin with 0b1001
		TEST_METHOD(sub)
		{
			const uint16_t SUB = 0b1001 << 12;

			subtestName = L"SUB with EA source";
			pushWord(SUB | SUB_REG(2) | SUB_OPMODE(0b010) | EA_MODE(2) | 3);
			runTest("sub.l", "(a3),d2");

			subtestName = L"SUB with EA dest";
			pushWord(SUB | SUB_REG(4) | SUB_OPMODE(0b101) | EA_MODE(2) | 5);
			runTest("sub.w", "d4,(a5)");

			subtestName = L"SUBA word";
			pushWord(SUB | SUB_REG(3) | SUB_OPMODE(0b011) | EA_MODE(0) | 0);
			runTest("suba.w", "d0,a3");

			subtestName = L"SUBA long";
			pushWord(SUB | SUB_REG(6) | SUB_OPMODE(0b111) | EA_MODE(0) | 5);
			runTest("suba.l", "d5,a6");

			const uint16_t SUBX = 0b1001000100000000;
			const uint16_t SUBX_ADDR_MODE_BIT = 0b1000;

			subtestName = L"SUBX register";
			pushWord(SUBX | SUB_REG(2) | SUBX_SIZE(0b01) | 4);
			runTest("subx.w", "d4,d2");

			subtestName = L"SUBX memory";
			pushWord(SUBX | SUB_REG(4) | SUBX_SIZE(0b10) | SUBX_ADDR_MODE_BIT | 0);
			runTest("subx.l", "-(a0),-(a4)");
		}

		TEST_METHOD(link_unlk)
		{
			const uint16_t LINK = 0b0100111001010000;
			const uint16_t UNLK = 0b0100111001011000;

			subtestName = L"LINK Positive";
			pushWord(LINK | 5);
			pushWord(20);
			runTest("link.w", "a5,#20");

			subtestName = L"LINK Negative";
			pushWord(LINK | 3);
			pushWord(-3);
			runTest("link.w", "a3,#-3");

			subtestName = L"UNLINK";
			pushWord(UNLK | 5);
			runTest("unlk", "a5");
		}

		TEST_METHOD(biti_size)
		{
			const uint16_t ORI = 0 << 9;
			const uint16_t ANDI = 1 << 9;
			const uint16_t SUBI = 2 << 9;
			const uint16_t ADDI = 3 << 9;
			/* 4 << 9 is part of the bit test opcodes */
			const uint16_t EORI = 5 << 9;
			const uint16_t CMPI = 6 << 9;

			const auto SIZE = [](uint16_t value) { return value << 6; };

			// Bitwise stuff should always use hex constants

			subtestName = L"ORI.b";
			pushWord(ORI | SIZE(0) | EA_MODE(0) | 4);
			pushWord(0x45);
			runTest("ori.b", "#$45,d4");

			subtestName = L"ANDI.w";
			pushWord(ANDI | SIZE(1) | EA_MODE(2) | 5);
			pushWord(0x22b0);
			runTest("andi.w", "#$22b0,(a5)");

			subtestName = L"Negative byte sized values are printed correctly";
			pushWord(ORI | SIZE(0) | EA_MODE(0) | 0);
			pushWord(0xFF);
			runTest("ori.b", "#$ff,d0");

			subtestName = L"Invalid byte values are ignored";
			pushWord(ORI | SIZE(0) | EA_MODE(0) | 0);
			pushWord(0x01FF);
			runFailTest();

			subtestName = L"Non-spec negative byte values are allowed";
			pushWord(ORI | SIZE(0) | EA_MODE(0) | 0);
			pushWord(0xFFFF);
			runTest("ori.b", "#$ff,d0");

			// Other stuff is dependent on size

			subtestName = L"SUBI.l";
			pushWord(SUBI | SIZE(2) | EA_MODE(0) | 0);
			pushWord(0xdead);
			pushWord(0xbeef);
			runTest("subi.l", "#-559038737,d0");

			subtestName = L"CMPI.b";
			pushWord(CMPI | SIZE(0) | EA_MODE(3) | 4);
			pushWord(78);
			runTest("cmpi.b", "#78,(a4)+");

			// Make sure labels work correctly

			subtestName = L"ORI labelled memory address";
			pushWord(ORI | SIZE(1) | EA_MODE(5) | 6);
			pushWord(0x31);
			pushWord(88);
			labelManager->addLabel(&UNKNOWN_DATA_SPACE, 88 + 0x8000, "hello");
			runTest("ori.w", "#$0031,hello(a6)");
			labelManager->clear();

			// TODO: ANDI external-ref constant
		}

		TEST_METHOD(bit_dynamic)
		{
			const auto DEST_REG = [](uint16_t reg) { return reg << 9; };
			const uint16_t BSET = 0b111000000;

			subtestName = L"Regression test: make sure writable modes are allowed";
			pushWord(BSET | DEST_REG(5) | EA_MODE(Displacement) | 1);
			pushWord(-1);
			runTest("bset.b", "d5,-1(a1)");
		}

		// Test situations (in roff or module) where trap has to guess parameters.
		TEST_METHOD(trap_guess)
		{
			const uint16_t TRAP = 0b0100111001000000;
			const uint16_t MATH_TRAP = 15;

			// Test valid OS9 traps
			subtestName = L"OS9 Unlink Trap";
			pushWord(TRAP | 0);
			pushWord(0x02);
			runTest("os9", "F$UnLink");

			subtestName = L"OS9 Event trap";
			pushWord(TRAP | 0);
			pushWord(0x53);
			runTest("os9", "F$Event");

			subtestName = L"OS9 Seek trap";
			pushWord(TRAP | 0);
			pushWord(0x88);
			runTest("os9", "I$Seek");

			// Test invalid OS9 traps
			subtestName = L"Invalid Syscall: Too big";
			pushWord(TRAP | 0);
			pushWord(163);
			runTest("os9", "#163");

			subtestName = L"Invalid Syscall: Gap between syscalls";
			pushWord(TRAP | 0);
			pushWord(0x70);
			runTest("os9", "#112");

			// Test valid T$Math traps
			subtestName = L"Math Tangent trap";
			pushWord(TRAP | MATH_TRAP);
			pushWord(0x30);
			runTest("tcall", "T$Math,T$Tan");

			// Test invalid T$Math traps
			subtestName = L"Math invalid trap";
			pushWord(TRAP | MATH_TRAP);
			pushWord(68);
			runTest("tcall", "#15,#68");

			// Test user traps
			subtestName = L"User trap";
			pushWord(TRAP | 1);
			pushWord(0x40);
			runTest("tcall", "#1,#64");
		}

		// Test situations where ROF symbols are defined for the trap site.
		TEST_METHOD(trap_noguess)
		{
			const uint16_t TRAP = 0b0100111001000000;
			const uint16_t MATH_TRAP = 15;
			opt.IsROF = true;

			// Test valid syscalls
			subtestName = L"Syscall Unlink trap";
			pushWord(TRAP | 0);
			pushWord(0);
			rof_extrn unlink(0, 2, true);
			unlink.hasName = true;
			unlink.nam = "F$UnLink";
			refs_code.insert(std::make_pair<uint32_t, rof_extrn>(2, std::move(unlink)));
			runTest("os9", "F$UnLink");
			refs_code.clear();

			// Test valid T$Math traps
			subtestName = L"Math Tangent trap";
			pushWord(TRAP | MATH_TRAP);
			pushWord(0);
			rof_extrn temp(0, 1, true);
			temp.hasName = true;
			temp.nam = "T$Math";
			refs_code.insert(std::make_pair<uint32_t, rof_extrn>(1, std::move(temp)));
			rof_extrn temp2(0, 2, true);
			temp2.hasName = true;
			temp2.nam = "T$Tan";
			refs_code.insert(std::make_pair<uint32_t, rof_extrn>(2, std::move(temp2)));
			runTest("tcall", "T$Math,T$Tan");
			refs_code.clear();
		}
	};
}