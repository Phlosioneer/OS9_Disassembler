
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

		void runTest(std::string expectedMneumonic, std::string expectedParams)
		{
			stream = std::make_unique<BigEndianStream>(std::move(testData));
			state.Module = stream.get();

			struct cmd_items instr;
			Assert::IsTrue(get_asmcmd(&instr, &state), subtestName);
			Assert::AreEqual(expectedMneumonic, instr.mnem, subtestName);
			std::string params = instr.renderParams();
			
			Assert::AreEqual(expectedParams, params, subtestName);
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
			const uint16_t MOVE_FROM_SR = 0b0100000011000000;
			const uint16_t MOVE_FROM_CCR = 0b0100001011000000;
			const uint16_t MOVE_TO_CCR = 0b0100010011000000;
			const uint16_t MOVE_TO_SR = 0b0100011011000000;

			pushWord(MOVE_TO_SR | EA_MODE(7) | 4);
			pushWord(0x13); // Arbitrary 5-bit value
			runTest("move", "#19,sr");

			subtestName = L"MOVE from SR to D6";
			pushWord(MOVE_FROM_SR | EA_MODE(0) | 6);
			runTest("move", "sr,d6");

			subtestName = L"MOVE to CCR from D0";
			pushWord(MOVE_TO_CCR | EA_MODE(0) | 0);
			runTest("move", "d0,ccr");

			subtestName = L"MOVE from CCR to (A3)";
			pushWord(MOVE_FROM_CCR | EA_MODE(2) | 3);
			runTest("move", "ccr,(a3)");

			subtestName = L"Cannot MOVE from SR to Ax";
			pushWord(MOVE_FROM_SR | EA_MODE(DirectAddrReg) | 1);
			runFailTest();

			subtestName = L"MOVE from CCR to label";
			pushWord(MOVE_FROM_CCR | EA_MODE(Displacement) | 6);
			pushWord(63);
			labelManager.addLabel(&UNKNOWN_DATA_SPACE, 63 + 0x8000, "hello");
			runTest("move", "ccr,hello(a6)");

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

		TEST_METHOD(bit_rotate_mem)
		{
			const uint16_t A_SHIFT =    0b1110000011000000;
			const uint16_t L_SHIFT =    0b1110001011000000;
			const uint16_t ROTATE_EXT = 0b1110010011000000;
			const uint16_t ROTATE =     0b1110011011000000;
			const uint16_t LEFT_BIT = 1 << 8;

			subtestName = L"ASL";
			pushWord(A_SHIFT | LEFT_BIT | EA_MODE(2) | 3);
			runTest("asl", "(a3)");

			subtestName = L"ASR";
			labelManager.addLabel(&UNKNOWN_DATA_SPACE, 80 + 0x8000, "hello");
			pushWord(A_SHIFT | EA_MODE(5) | 6);
			pushWord(80);
			runTest("asr", "hello(a6)");

			subtestName = L"LSL";
			pushWord(L_SHIFT | LEFT_BIT | EA_MODE(2) | 0);
			runTest("lsl", "(a0)");

			subtestName = L"LSR";
			pushWord(L_SHIFT | EA_MODE(4) | 4);
			runTest("lsr", "-(a4)");

			subtestName = L"ROL";
			pushWord(ROTATE | LEFT_BIT | EA_MODE(2) | 1);
			runTest("rol", "(a1)");

			subtestName = L"ROR";
			pushWord(ROTATE | EA_MODE(2) | 7);
			runTest("ror", "(sp)");

			subtestName = L"ROXL";
			pushWord(ROTATE_EXT | LEFT_BIT | EA_MODE(2) | 1);
			runTest("roxl", "(a1)");

			subtestName = L"ROXR";
			pushWord(ROTATE_EXT | EA_MODE(2) | 1);
			runTest("roxr", "(a1)");
		}

		TEST_METHOD(bit_rotate_reg)
		{
			const uint16_t A_SHIFT =    0b1110000000000000;
			const uint16_t L_SHIFT =    0b1110000000001000;
			const uint16_t ROTATE_EXT = 0b1110000000010000;
			const uint16_t ROTATE =     0b1110000000011000;
			const uint16_t LEFT_BIT = 1 << 8;
			const auto COUNT = [](uint16_t n) { return ((n % 8) << 9) | (0 << 5); };
			const auto AMOUNT_REG = [](uint16_t code) { return (code << 9) | (1 << 5); };
			const auto SIZE = [](uint16_t code) { return code << 6; };
			const uint16_t BYTE = 0;
			const uint16_t WORD = 1;
			const uint16_t LONG = 2;

			subtestName = L"ASL byte with count";
			pushWord(A_SHIFT | LEFT_BIT | COUNT(5) | SIZE(BYTE) | 3);
			runTest("asl.b", "#5,d3");

			subtestName = L"ASL long with reg";
			pushWord(A_SHIFT | LEFT_BIT | AMOUNT_REG(5) | SIZE(LONG) | 3);
			runTest("asl.l", "d5,d3");

			subtestName = L"ASR word with count of 8";
			pushWord(A_SHIFT | COUNT(8) | SIZE(WORD) | 6);
			runTest("asr.w", "#8,d6");

			subtestName = L"LSL with reg";
			pushWord(L_SHIFT | LEFT_BIT | AMOUNT_REG(2) | SIZE(BYTE) | 0);
			runTest("lsl.b", "d2,d0");

			subtestName = L"LSR with count";
			pushWord(L_SHIFT | COUNT(1) | SIZE(BYTE) | 7);
			runTest("lsr.b", "#1,d7");

			subtestName = L"ROL with count";
			pushWord(ROTATE | LEFT_BIT | COUNT(7) | SIZE(LONG) | 4);
			runTest("rol.l", "#7,d4");

			subtestName = L"ROR with reg";
			pushWord(ROTATE | AMOUNT_REG(0) | SIZE(WORD) | 2);
			runTest("ror.w", "d0,d2");

			subtestName = L"ROXL with reg";
			pushWord(ROTATE_EXT | LEFT_BIT | AMOUNT_REG(4) | SIZE(LONG) | 4);
			runTest("roxl.l", "d4,d4");

			subtestName = L"ROXR with count";
			pushWord(ROTATE_EXT | COUNT(3) | SIZE(BYTE) | 0);
			runTest("roxr.b", "#3,d0");
		}

		TEST_METHOD(cmp_cmpa)
		{
			const uint16_t CMP = 0b1011 << 12;
			const auto DATA_REG = [](uint16_t code) { return code << 9; };
			const auto OPMODE = [](uint16_t code) { return code << 6; };
			const uint16_t CMP_BYTE = 0;
			const uint16_t CMP_WORD = 1;
			const uint16_t CMP_LONG = 2;
			const uint16_t CMPA_WORD = 3;
			const uint16_t CMPA_LONG = 7;

			subtestName = L"CMP Byte";
			pushWord(CMP | DATA_REG(4) | OPMODE(CMP_BYTE) | EA_MODE(PreDecrement) | 7);
			runTest("cmp.b", "-(sp),d4");

			subtestName = L"CMP Word";
			pushWord(CMP | DATA_REG(0) | OPMODE(CMP_WORD) | EA_MODE(Displacement) | 6);
			pushWord(88);
			labelManager.addLabel(&UNKNOWN_DATA_SPACE, 88 + 0x8000, "hello");
			runTest("cmp.w", "hello(a6),d0");
			labelManager.clear();

			subtestName = L"CMP Long";
			pushWord(CMP | DATA_REG(1) | OPMODE(CMP_LONG) | EA_MODE(DirectAddrReg) | 2);
			runTest("cmp.l", "a2,d1");

			subtestName = L"CMPA Word";
			pushWord(CMP | DATA_REG(2) | OPMODE(CMPA_WORD) | EA_MODE(DirectAddrReg) | 0);
			runTest("cmpa.w", "a0,a2");

			subtestName = L"CMPA Long";
			pushWord(CMP | DATA_REG(7) | OPMODE(CMPA_LONG) | EA_MODE(DirectDataReg) | 7);
			runTest("cmpa.l", "d7,sp");
		}

		TEST_METHOD(cmd_stop)
		{
			const uint16_t STOP = 0b0100111001110010;

			subtestName = L"STOP with immediate";
			pushWord(STOP);
			pushWord(9);
			runTest("stop", "#9");

			// TODO: L"STOP with external constant";
		}

		TEST_METHOD(cmd_scc)
		{
			const auto CONDITION = [](uint16_t code) { return code << 8; };
			const uint16_t SCC = 0b0101000011000000;

			subtestName = L"Data reg";
			pushWord(SCC | CONDITION(Condition::EQ) | EA_MODE(DirectDataReg) | 4);
			runTest("seq", "d4");

			subtestName = L"Labelled data";
			pushWord(SCC | CONDITION(Condition::T) | EA_MODE(Displacement) | 6);
			pushWord(88);
			labelManager.addLabel(&UNKNOWN_DATA_SPACE, 88 + 0x8000, "hello");
			runTest("st", "hello(a6)");
			labelManager.clear();

			subtestName = L"Constant fail";
			pushWord(SCC | CONDITION(Condition::GT) | EA_MODE(Special) | ImmediateData);
			pushWord(2);
			runFailTest();
		}

		TEST_METHOD(cmd_cmpm)
		{
			const auto SIZE = [](uint16_t code) { return code << 6; };
			const auto DEST_REG = [](uint16_t code) { return code << 9; };
			const uint16_t CMPM = 0b1011000100001000;
			const uint16_t BYTE = 0;
			const uint16_t WORD = 1;
			const uint16_t LONG = 2;

			subtestName = L"Byte";
			pushWord(CMPM | DEST_REG(3) | SIZE(BYTE) | 0);
			runTest("cmpm.b", "(a0)+,(a3)+");

			subtestName = L"Word";
			pushWord(CMPM | DEST_REG(2) | SIZE(WORD) | 7);
			runTest("cmpm.w", "(sp)+,(a2)+");

			subtestName = L"Long";
			pushWord(CMPM | DEST_REG(6) | SIZE(LONG) | 4);
			runTest("cmpm.l", "(a4)+,(a6)+");
		}

		TEST_METHOD(movep)
		{
			const auto DATA_REG = [](uint16_t code) { return code << 9; };
			const auto OPMODE = [](uint16_t code) { return code << 6; };
			const uint16_t MOVEP = 0b0000000000001000;
			const uint16_t WORD_MEM_TO_REG = 0b100;
			const uint16_t LONG_MEM_TO_REG = 0b101;
			const uint16_t WORD_REG_TO_MEM = 0b110;
			const uint16_t LONG_REG_TO_MEM = 0b111;

			subtestName = L"Word mem to reg";
			pushWord(MOVEP | DATA_REG(6) | OPMODE(WORD_MEM_TO_REG) | 0);
			pushWord(456);
			runTest("movep.w", "456(a0),d6");

			subtestName = L"Long mem to reg";
			pushWord(MOVEP | DATA_REG(3) | OPMODE(LONG_MEM_TO_REG) | 4);
			pushWord(0);
			runTest("movep.l", "0(a4),d3");

			subtestName = L"Word reg to mem";
			pushWord(MOVEP | DATA_REG(0) | OPMODE(WORD_REG_TO_MEM) | 7);
			pushWord(7);
			runTest("movep.w", "d0,7(sp)");

			subtestName = L"Long reg to mem";
			pushWord(MOVEP | DATA_REG(5) | OPMODE(LONG_REG_TO_MEM) | 2);
			pushWord(3105);
			runTest("movep.l", "d5,3105(a2)");

			subtestName = L"Displacement labels";
			labelManager.addLabel(&UNKNOWN_DATA_SPACE, 90 + 0x8000, "hello");
			pushWord(MOVEP | DATA_REG(1) | OPMODE(LONG_MEM_TO_REG) | 6);
			pushWord(90);
			runTest("movep.l", "hello(a6),d1");
			labelManager.clear();

			subtestName = L"MOVEP Invalid OPMODE=3";
			pushWord(MOVEP | OPMODE(0b011));
			pushWord(0);
			runFailTest();

			subtestName = L"MOVEP Invalid OPMODE=0";
			pushWord(MOVEP | OPMODE(0));
			pushWord(0);
			runFailTest();
		}
	};
}
