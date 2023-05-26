
#include <sstream>

#include "CppUnitTest.h"
#include "CppUnitTestAssert.h"

#include "params.h"
#include "label.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTests
{
	TEST_CLASS(ParamUnitTests)
	{
	public:
		TEST_METHOD(makeRegTest)
		{
			Assert::AreEqual(static_cast<int>(Register::A4), static_cast<int>(Registers::makeAReg(4)));
			Assert::AreEqual(static_cast<int>(Register::D2), static_cast<int>(Registers::makeDReg(2)));
			Assert::AreEqual(static_cast<int>(Register::SP), static_cast<int>(Registers::makeAReg(7)));
		}

		TEST_METHOD(LiteralTest)
		{
			Assert::AreEqual(std::string("#0"), LiteralParam(FormattedNumber(0)).toStr());
			Assert::AreEqual(std::string("#5"), LiteralParam(FormattedNumber(5)).toStr());
			Assert::AreEqual(std::string("#10"), LiteralParam(FormattedNumber(10)).toStr());
			Assert::AreEqual(std::string("#100"), LiteralParam(FormattedNumber(100)).toStr());
			Assert::AreEqual(std::string("#70000"), LiteralParam(FormattedNumber(70000)).toStr());
			Assert::AreEqual(std::string("#-3"), LiteralParam(FormattedNumber(-3)).toStr());

			//Label test('L', 0, "hello");
			Assert::AreEqual(std::string("hello"), LiteralParam(std::string("hello")).toStr());
		}

		TEST_METHOD(RegParamTest)
		{
			Assert::AreEqual(std::string("d0"), RegParam(Register::D0).toStr());
			Assert::AreEqual(std::string("a3"), RegParam(Register::A3).toStr());

			Assert::AreEqual(std::string("(a2)"), RegParam(Register::A2, RegParamMode::Indirect).toStr());
			Assert::AreEqual(std::string("-(sp)"), RegParam(Register::SP, RegParamMode::PreDecrement).toStr());
			Assert::AreEqual(std::string("(sp)+"), RegParam(Register::SP, RegParamMode::PostIncrement).toStr());

			auto test = [] { RegParam t(Register::D1, RegParamMode::PostIncrement); };
			Assert::ExpectException<std::exception>(+test);
		}

		TEST_METHOD(RegOffsetParamTest)
		{
			auto zeroOffset = RegOffsetParam(Register::A2, FormattedNumber(0));
			Assert::AreEqual(std::string("(a2)"), zeroOffset.toStr());
			zeroOffset.setShouldForceZero(true);
			Assert::AreEqual(std::string("0(a2)"), zeroOffset.toStr());

			auto zeroLabel = RegOffsetParam(Register::A2, std::string("hello"));
			Assert::AreEqual(std::string("hello(a2)"), zeroLabel.toStr());
			zeroLabel.setShouldForceZero(true);
			Assert::AreEqual(std::string("hello(a2)"), zeroLabel.toStr());

			auto nonzeroOffset = RegOffsetParam(Register::PC, FormattedNumber(40));
			Assert::AreEqual(std::string("40(pc)"), nonzeroOffset.toStr());
			zeroLabel.setShouldForceZero(true);
			Assert::AreEqual(std::string("40(pc)"), nonzeroOffset.toStr());

			auto zeroOffset2 = RegOffsetParam(Register::A2, Register::D5, OperandSize::Long, FormattedNumber(0));
			Assert::AreEqual(std::string("(a2,d5.l)"), zeroOffset2.toStr());
			
			auto zeroLabel2 = RegOffsetParam(Register::A2, Register::D5, OperandSize::Long, std::string("hello"));
			Assert::AreEqual(std::string("hello(a2,d5.l)"), zeroLabel2.toStr());

			auto nonzeroOffset2 = RegOffsetParam(Register::PC, Register::D1, OperandSize::Word, FormattedNumber(40));
			Assert::AreEqual(std::string("40(pc,d1.w)"), nonzeroOffset2.toStr());

			auto badBaseReg = [] { RegOffsetParam test(Register::D0, FormattedNumber(0)); };
			Assert::ExpectException<std::exception>(badBaseReg);
		}

		TEST_METHOD(OperandTruncationUnsignedTest)
		{
			// Check negative numbers
			auto actual = OperandSizes::truncateUnsigned(OperandSize::Byte, -1);
			Assert::AreEqual((uint32_t)0xFF, actual);

			actual = OperandSizes::truncateUnsigned(OperandSize::Word, -1);
			Assert::AreEqual((uint32_t)0xFFFF, actual);

			// Check oversized numbers
			const uint32_t oversized = 0x12345678;
			actual = OperandSizes::truncateUnsigned(OperandSize::Byte, oversized);
			Assert::AreEqual((uint32_t)0x78, actual);

			actual = OperandSizes::truncateUnsigned(OperandSize::Word, oversized);
			Assert::AreEqual((uint32_t)0x5678, actual);

			// Check oversized numbers with top bit set
			const uint32_t oversizedTopBit = 0xF234F6F8;
			actual = OperandSizes::truncateUnsigned(OperandSize::Byte, oversizedTopBit);
			Assert::AreEqual((uint32_t)0xF8, actual);

			actual = OperandSizes::truncateUnsigned(OperandSize::Word, oversizedTopBit);
			Assert::AreEqual((uint32_t)0xF6F8, actual);

			// Check correctly sized numbers with top bit set
			actual = OperandSizes::truncateUnsigned(OperandSize::Byte, 0xFF);
			Assert::AreEqual((uint32_t)0xFF, actual);

			actual = OperandSizes::truncateUnsigned(OperandSize::Word, 0xFFFF);
			Assert::AreEqual((uint32_t)0xFFFF, actual);
		}

		TEST_METHOD(OperandTruncationSignedTest)
		{
			// Check negative numbers
			auto actual = OperandSizes::truncateSigned(OperandSize::Byte, -1);
			Assert::AreEqual((int32_t)0xFFFFFFFF, actual);

			actual = OperandSizes::truncateSigned(OperandSize::Word, -1);
			Assert::AreEqual((int32_t)0xFFFFFFFF, actual);

			// Check oversized numbers
			const int32_t oversized = 0x12345678;
			actual = OperandSizes::truncateSigned(OperandSize::Byte, oversized);
			Assert::AreEqual((int32_t)0x78, actual);

			actual = OperandSizes::truncateSigned(OperandSize::Word, oversized);
			Assert::AreEqual((int32_t)0x5678, actual);

			// Check oversized numbers with top bit set
			const int32_t oversizedTopBit = 0xF234F6F8;
			actual = OperandSizes::truncateSigned(OperandSize::Byte, oversizedTopBit);
			Assert::AreEqual((int32_t)0xFFFFFFF8, actual);

			actual = OperandSizes::truncateSigned(OperandSize::Word, oversizedTopBit);
			Assert::AreEqual((int32_t)0xFFFFF6F8, actual);

			// Check correctly sized numbers with top bit set
			actual = OperandSizes::truncateSigned(OperandSize::Byte, 0xFF);
			Assert::AreEqual((int32_t)0xFFFFFFFF, actual);

			actual = OperandSizes::truncateSigned(OperandSize::Word, 0xFFFF);
			Assert::AreEqual((int32_t)0xFFFFFFFF, actual);
		}
	};
}
