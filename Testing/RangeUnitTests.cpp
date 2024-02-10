#include "CppUnitTest.h"

#include "range.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

template<>
std::wstring Microsoft::VisualStudio::CppUnitTestFramework::ToString(const Range32& value) {
	std::wostringstream buffer;
	buffer << '(' << value.start() << ", " << value.end() << ']';
	return buffer.str();
}

namespace UnitTests
{

	TEST_CLASS(RangeTests)
	{
	public:
		

		TEST_METHOD(ConstructorOrderTest)
		{
			Assert::AreEqual(Range32(5, 20), Range32(20, 5));
			Assert::AreEqual(Range32(0, 0), Range32(0, 0));

			Assert::AreNotEqual(Range32(5, 20), Range32(6, 20));
			Assert::AreNotEqual(Range32(1, 1), Range32(3, 3));
		}

		TEST_METHOD(ContainsPointTest)
		{
			Range32 r{ 20, 23 }, r_zero{ 20, 20 };

			Assert::IsFalse(r.contains(19));
			Assert::IsTrue(r.contains(20));
			Assert::IsTrue(r.contains(21));
			Assert::IsTrue(r.contains(22));
			Assert::IsFalse(r.contains(23));

			Assert::IsFalse(r_zero.contains(19));
			Assert::IsFalse(r_zero.contains(20));
			Assert::IsFalse(r_zero.contains(21));
		}

		TEST_METHOD(AdjacentTest)
		{
			// Adjacent ranges
			Range32 r1{ 5, 20 }, r2{ 20, 25 }, r_zero{ 20, 20 };
			Assert::IsTrue(r1.adjacent(r2));
			Assert::IsTrue(r2.adjacent(r1));
			Assert::IsTrue(r1.adjacent(r_zero));
			Assert::IsTrue(r_zero.adjacent(r1));
			Assert::IsTrue(r2.adjacent(r_zero));
			Assert::IsTrue(r_zero.adjacent(r2));

			// Self-comparisons.
			Assert::IsTrue(r_zero.adjacent(r_zero));
			Assert::IsFalse(r1.adjacent(r1));
			Assert::IsFalse(r2.adjacent(r2));

			// Overlapping ranges (with r2)
			Range32 overlap1{ 5, 22 }, overlap2{ 20, 28 };
			Range32 inside{ 21, 25 }, inside_zero{ 22, 22 };
			Assert::IsFalse(r2.adjacent(overlap1));
			Assert::IsFalse(overlap1.adjacent(r2));
			Assert::IsFalse(r2.adjacent(overlap2));
			Assert::IsFalse(overlap2.adjacent(r2));
			Assert::IsFalse(r2.adjacent(inside));
			Assert::IsFalse(inside.adjacent(r2));
			Assert::IsFalse(r2.adjacent(inside_zero));
			Assert::IsFalse(inside_zero.adjacent(r2));

			// Disjoint ranges (with r2)
			Range32 higher{ 30, 32 }, lower{ 1, 2 }, higher_zero{ 40, 40 };
			Assert::IsFalse(r2.adjacent(higher));
			Assert::IsFalse(higher.adjacent(r2));
			Assert::IsFalse(r2.adjacent(lower));
			Assert::IsFalse(lower.adjacent(r2));
			Assert::IsFalse(r2.adjacent(higher_zero));
			Assert::IsFalse(higher_zero.adjacent(r2));
		}

		TEST_METHOD(IntersectionTest)
		{
			// Adjacent ranges
			const Range32 r1{ 5, 20 }, r2{ 20, 25 }, r_zero{ 20, 20 };
			Assert::IsFalse(r1.intersects(r2));
			Assert::IsFalse(r2.intersects(r1));
			Assert::IsFalse(r1.intersects(r_zero));
			Assert::IsFalse(r_zero.intersects(r1));
			Assert::IsFalse(r2.intersects(r_zero));
			Assert::IsFalse(r_zero.intersects(r2));

			// Self-comparisons.
			Assert::IsFalse(r_zero.intersects(r_zero));
			Assert::IsTrue(r1.intersects(r1));
			Assert::IsTrue(r2.intersects(r2));

			// Overlapping ranges (with r2)
			const Range32 overlap1{ 5, 22 }, overlap2{ 20, 28 };
			const Range32 inside{ 21, 25 }, inside_zero{ 22, 22 };
			Assert::IsTrue(r2.intersects(overlap1));
			Assert::IsTrue(overlap1.intersects(r2));
			Assert::IsTrue(r2.intersects(overlap2));
			Assert::IsTrue(overlap2.intersects(r2));
			Assert::IsTrue(r2.intersects(inside));
			Assert::IsTrue(inside.intersects(r2));
			Assert::IsTrue(r2.intersects(inside_zero));
			Assert::IsTrue(inside_zero.intersects(r2));

			// Disjoint ranges (with r2)
			const Range32 higher{ 30, 32 }, lower{ 1, 2 }, higher_zero{ 40, 40 };
			Assert::IsFalse(r2.intersects(higher));
			Assert::IsFalse(higher.intersects(r2));
			Assert::IsFalse(r2.intersects(lower));
			Assert::IsFalse(lower.intersects(r2));
			Assert::IsFalse(r2.intersects(higher_zero));
			Assert::IsFalse(higher_zero.intersects(r2));

			// Extra checks around zero-sized ranges.
			Assert::IsFalse(r2.intersects(Range32(19, 19)));
			Assert::IsFalse(r2.intersects(Range32(20, 20)));
			Assert::IsTrue(r2.intersects(Range32(21, 21)));
			Assert::IsTrue(r2.intersects(Range32(22, 22)));
			Assert::IsTrue(r2.intersects(Range32(23, 23)));
			Assert::IsTrue(r2.intersects(Range32(24, 24)));
			Assert::IsFalse(r2.intersects(Range32(25, 25)));
			Assert::IsFalse(r2.intersects(Range32(26, 26)));

			Assert::IsFalse(Range32(19, 19).intersects(r2));
			Assert::IsFalse(Range32(20, 20).intersects(r2));
			Assert::IsTrue(Range32(21, 21).intersects(r2));
			Assert::IsTrue(Range32(22, 22).intersects(r2));
			Assert::IsTrue(Range32(23, 23).intersects(r2));
			Assert::IsTrue(Range32(24, 24).intersects(r2));
			Assert::IsFalse(Range32(25, 25).intersects(r2));
			Assert::IsFalse(Range32(26, 26).intersects(r2));
		}

		TEST_METHOD(UnionAndMergeTest)
		{
			const auto testGoodPair = [](const Range32& a, const Range32& b, const Range32& output) {
				bool success = false;
				Range32 temp;

				Assert::IsTrue(a.canMerge(b));
				Assert::IsTrue(b.canMerge(a));
				
				Assert::AreEqual(output, a.doUnion(b));
				Assert::AreEqual(output, b.doUnion(a));
				
				Assert::AreEqual(output, Range32(a).merge(b));
				Assert::AreEqual(output, Range32(b).merge(a));
				
				temp = a.tryUnion(b, success);
				Assert::IsTrue(success);
				Assert::AreEqual(output, temp);
				success = false;
				temp = b.tryUnion(a, success);
				Assert::IsTrue(success);
				Assert::AreEqual(output, temp);

				temp = Range32(a);
				Assert::IsTrue(temp.tryMerge(b));
				Assert::AreEqual(output, temp);
				success = false;
				temp = Range32(b);
				Assert::IsTrue(temp.tryMerge(a));
				Assert::AreEqual(output, temp);

			};

			const auto testBadPair = [](const Range32& a, const Range32& b) {
				bool success = true;
				Range32 temp{};

				Assert::IsFalse(a.canMerge(b));
				Assert::IsFalse(b.canMerge(a));

				//Assert::ExpectException<std::runtime_error, Range32>([&]() {return a.doUnion(b); });
				//Assert::ExpectException<std::runtime_error, void>([&]() {b.doUnion(a); });

				//Assert::ExpectException<std::runtime_error, void>([&]() {Range32(a).merge(b); });
				//Assert::ExpectException<std::runtime_error, void>([&]() {Range32(b).merge(a); });

				temp = a.tryUnion(b, success);
				Assert::IsFalse(success);
				Assert::AreEqual(Range32(), temp);
				success = true;
				temp = b.tryUnion(a, success);
				Assert::IsFalse(success);
				Assert::AreEqual(Range32(), temp);

				temp = Range32(a);
				Assert::IsFalse(temp.tryMerge(b));
				Assert::AreEqual(a, temp);
				success = true;
				temp = Range32(b);
				Assert::IsFalse(temp.tryMerge(a));
				Assert::AreEqual(b, temp);

			};

			// Adjacent ranges
			const Range32 r1{ 5, 20 }, r2{ 20, 25 }, r_zero{ 20, 20 };
			testGoodPair(r1, r2, Range32(5, 25));
			testGoodPair(r1, r_zero, r1);
			testGoodPair(r2, r_zero, r2);
			
			// Self-comparisons.
			testGoodPair(r1, r1, r1);
			testGoodPair(r2, r2, r2);
			testGoodPair(r_zero, r_zero, r_zero);

			// Overlapping ranges (with r2)
			const Range32 overlap1{ 5, 22 }, overlap2{ 20, 28 };
			const Range32 inside{ 21, 25 }, inside_zero{ 22, 22 };
			testGoodPair(r2, overlap1, Range32(5, 25));
			testGoodPair(r2, overlap2, Range32(20, 28));
			testGoodPair(r2, inside, r2);
			testGoodPair(r2, inside_zero, r2);

			// Disjoint ranges (with r2)
			const Range32 higher{ 30, 32 }, lower{ 1, 2 }, higher_zero{ 40, 40 };
			testBadPair(r2, higher);
			testBadPair(r2, lower);
			testBadPair(r2, higher_zero);
		}
	};
}