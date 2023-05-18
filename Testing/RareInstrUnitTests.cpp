
#include <sstream>

#include "CppUnitTest.h"

#include "command_items.h"
#include "main_support.h"
#include "dprint.h"
#include "writer.h"
#include "reset.h"
#include "label.h"
#include "modtypes.h"

#define EA_MODE(a) ((a) << 3)
#define MOVEP_OPMODE(a) ((a) << 6)
#define MOVEP_DAT_REG(a) ((a) << 9)
#define MOVEP_ADDR_REG(a) (a)

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTests
{
	TEST_CLASS(RareInstructionUnitTests)
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
			Assert::AreEqual(expectedParams, instr.params, subtestName);
		}

		void runFailTest()
		{
			stream = std::make_unique<BigEndianStream>(std::move(testData));
			state.Module = stream.get();

			struct cmd_items instr;
			Assert::IsFalse(get_asmcmd(&instr, &state), subtestName);
		}

		// This doesn't belong in RareInstruction tests; this is more of an
		// edge-case test.
		TEST_METHOD(biti_reg)
		{
			const uint16_t ORI_TO_CCR = 0x003C;

			// Test ORI to CCR works with a 5 bit immediate.
			subtestName = L"ORI to CCR, 5-bit";
			pushWord(ORI_TO_CCR);
			pushWord(0x13); // Arbitrary 5-bit value
			runTest("ori", "#19,ccr");

			// Test ORI to CCR fails for immediates with more than 5 bits.
			subtestName = L"ORI to CCR, 6-bit";
			pushWord(ORI_TO_CCR);
			pushWord(0x23); // Arbitrary 6-bit value
			runFailTest();

			// TODO: Test with ROF external constant as immediate value
		}

		TEST_METHOD(move_ccr_sr)
		{
			subtestName = L"MOVE to SR from immediate";
			const uint16_t MOVE_TO_SR = 0x46C0;
			pushWord(MOVE_TO_SR | EA_MODE(7) | 4);
			pushWord(0x13); // Arbitrary 5-bit value
			runTest("move", "#19,sr");

			subtestName = L"MOVE from SR to D6";
			const uint16_t MOVE_FROM_SR = 0b0100000011000000;
			pushWord(MOVE_FROM_SR | EA_MODE(0) | 6);
			runTest("move", "sr,d6");

			subtestName = L"MOVE to CCR from D0";
			const uint16_t MOVE_TO_CCR = 0b0100010011000000;
			pushWord(MOVE_TO_CCR | EA_MODE(0) | 0);
			runTest("move", "d0,ccr");

			subtestName = L"MOVE from CCR to (A3)";
			const uint16_t MOVE_FROM_CCR = 0b0100001011000000;
			pushWord(MOVE_FROM_CCR | EA_MODE(2) | 3);
			runTest("move", "ccr,(a3)");

			// TODO: Test moving CCR/SR to/from A6-relative label

			// TODO: Test moving ROF-external constant into CCR/SR
		}

		TEST_METHOD(move_usp)
		{
			const uint16_t MOVE_USP = 0b0100111001100000;
			const uint16_t INTO_REG_FLAG = 0b1000;
			
			subtestName = L"MOVE from USP to A2";
			pushWord(MOVE_USP | INTO_REG_FLAG | 2);
			runTest("move", "usp,a2");

			subtestName = L"MOVE from A5 to USP";
			pushWord(MOVE_USP | 5);
			runTest("move", "a5,usp");
		}

		TEST_METHOD(movep)
		{
			const uint16_t MOVEP = 0b1000;

			subtestName = L"MOVEP 90(a3) into D2";
			pushWord(MOVEP | MOVEP_ADDR_REG(3) | MOVEP_DAT_REG(2) | MOVEP_OPMODE(0b101));
			pushWord(90);
			runTest("movep.l", "90(a3),d2");

			subtestName = L"MOVEP D2 into (A1)";
			pushWord(MOVEP | MOVEP_ADDR_REG(1) | MOVEP_DAT_REG(2) | MOVEP_OPMODE(0b110));
			pushWord(0);
			runTest("movep.w", "d2,(a1)");

			subtestName = L"MOVEP Invalid OPMODE=3";
			pushWord(MOVEP | MOVEP_OPMODE(0b011));
			pushWord(0);
			runFailTest();

			subtestName = L"MOVEP Invalid OPMODE=0";
			pushWord(MOVEP | MOVEP_OPMODE(0));
			pushWord(0);
			runFailTest();

			// TODO: Test moving to/from A6-relative label
		}

		TEST_METHOD(bit_rotate_mem)
		{
			const uint16_t A_SHIFT = 0b1110000011000000;
			const uint16_t LEFT_BIT = 1 << 8;

			subtestName = L"ASL";
			pushWord(A_SHIFT | LEFT_BIT | EA_MODE(2) | 3);
			runTest("asl", "(a3)");

			subtestName = L"ASR";
			addlbl(&UNKNOWN_DATA_SPACE, 80 + 0x8000, "hello");
			pushWord(A_SHIFT | EA_MODE(5) | 6);
			pushWord(80);
			runTest("asr", "hello(a6)");

			const uint16_t L_SHIFT = 0b1110001011000000;
			subtestName = L"LSL";
			pushWord(L_SHIFT | LEFT_BIT | EA_MODE(2) | 0);
			runTest("lsl", "(a0)");

			subtestName = L"LSR";
			pushWord(L_SHIFT | EA_MODE(4) | 4);
			runTest("lsr", "-(a4)");

			const uint16_t ROTATE = 0b1110011011000000;
			subtestName = L"ROL";
			pushWord(ROTATE | LEFT_BIT | EA_MODE(2) | 1);
			runTest("rol", "(a1)");

			subtestName = L"ROR";
			pushWord(ROTATE | EA_MODE(2) | 7);
			runTest("ror", "(sp)");

			const uint16_t ROTATE_EXT = 0b1110010011000000;
			subtestName = L"ROXL";
			pushWord(ROTATE_EXT | LEFT_BIT | EA_MODE(2) | 1);
			runTest("roxl", "(a1)");

			subtestName = L"ROXR";
			pushWord(ROTATE_EXT | EA_MODE(2) | 1);
			runTest("roxr", "(a1)");
		}

		// TODO: TEST_METHOD(cmp_cmpa)
		//{
		//
		//}

		// TODO: TEST_METHOD(abcd_sbcd)
		//{
		//
		//}

		TEST_METHOD(cmd_stop)
		{
			const uint16_t STOP = 0b0100111001110010;
			
			subtestName = L"STOP with immediate";
			pushWord(STOP);
			pushWord(9);
			runTest("stop", "#9");

			// TODO: L"STOP with external constant";
		}

		// TODO: TEST_METHOD(cmd_scc)
		//{
		//
		//}
	};
}
