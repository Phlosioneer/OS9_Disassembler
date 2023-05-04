
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
			Assert::AreEqual(std::string("d0"), RegParam(Register::REG_D0).toStr());
			Assert::AreEqual(std::string("a3"), RegParam(Register::A3).toStr());

			Assert::AreEqual(std::string("(a2)"), RegParam(Register::A2, RegParamMode::Indirect).toStr());
			Assert::AreEqual(std::string("-(sp)"), RegParam(Register::SP, RegParamMode::PreDecrement).toStr());
			Assert::AreEqual(std::string("(sp)+"), RegParam(Register::SP, RegParamMode::PostIncrement).toStr());

			auto test = [] { RegParam(Register::D1, RegParamMode::PostIncrement); };
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

			auto nonzeroOffset = RegOffsetParam(Register::REG_PC, FormattedNumber(40));
			Assert::AreEqual(std::string("40(pc)"), nonzeroOffset.toStr());
			zeroLabel.setShouldForceZero(true);
			Assert::AreEqual(std::string("40(pc)"), nonzeroOffset.toStr());

			auto zeroOffset2 = RegOffsetParam(Register::A2, Register::D5, OperandSize::Long, FormattedNumber(0));
			Assert::AreEqual(std::string("(a2,d5.l)"), zeroOffset2.toStr());
			
			auto zeroLabel2 = RegOffsetParam(Register::A2, Register::D5, OperandSize::Long, std::string("hello"));
			Assert::AreEqual(std::string("hello(a2,d5.l)"), zeroLabel2.toStr());

			auto nonzeroOffset2 = RegOffsetParam(Register::REG_PC, Register::D1, OperandSize::Word, FormattedNumber(40));
			Assert::AreEqual(std::string("40(pc,d1.w)"), nonzeroOffset2.toStr());

			auto badBaseReg = [] { RegOffsetParam test(Register::REG_D0, FormattedNumber(0)); };
			Assert::ExpectException<std::exception>(badBaseReg);
		}
	};
}
