#include "CppUnitTest.h"

#include "range.h"
#include "util.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

typedef Range<uint32_t> Range32;



namespace UnitTests
{

	TEST_CLASS(RangeUnitTests)
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

		TEST_METHOD(ContainsRangeTest)
		{
			// Adjacent ranges
			const Range32 r1{ 5, 20 }, r2{ 20, 25 }, r_zero{ 20, 20 };
			Assert::IsFalse(r1.contains(r2));
			Assert::IsFalse(r2.contains(r1));
			Assert::IsFalse(r1.contains(r_zero));
			Assert::IsFalse(r_zero.contains(r1));
			Assert::IsFalse(r2.contains(r_zero));
			Assert::IsFalse(r_zero.contains(r2));

			// Self-comparisons.
			Assert::IsFalse(r_zero.contains(r_zero));
			Assert::IsTrue(r1.contains(r1));
			Assert::IsTrue(r2.contains(r2));

			// Overlapping ranges (with r2)
			const Range32 overlap1{ 5, 22 }, overlap2{ 20, 28 };
			const Range32 inside{ 21, 25 }, inside_zero{ 22, 22 };
			Assert::IsFalse(r2.contains(overlap1));
			Assert::IsFalse(overlap1.contains(r2));
			Assert::IsFalse(r2.contains(overlap2));
			Assert::IsTrue(overlap2.contains(r2));
			Assert::IsTrue(r2.contains(inside));
			Assert::IsFalse(inside.contains(r2));
			Assert::IsTrue(r2.contains(inside_zero));
			Assert::IsFalse(inside_zero.contains(r2));

			// Disjoint ranges (with r2)
			const Range32 higher{ 30, 32 }, lower{ 1, 2 }, higher_zero{ 40, 40 };
			Assert::IsFalse(r2.contains(higher));
			Assert::IsFalse(higher.contains(r2));
			Assert::IsFalse(r2.contains(lower));
			Assert::IsFalse(lower.contains(r2));
			Assert::IsFalse(r2.contains(higher_zero));
			Assert::IsFalse(higher_zero.contains(r2));

			// Extra checks around zero-sized ranges.
			Assert::IsFalse(r2.contains(Range32(19, 19)));
			Assert::IsFalse(r2.contains(Range32(20, 20)));
			Assert::IsTrue(r2.contains(Range32(21, 21)));
			Assert::IsTrue(r2.contains(Range32(22, 22)));
			Assert::IsTrue(r2.contains(Range32(23, 23)));
			Assert::IsTrue(r2.contains(Range32(24, 24)));
			Assert::IsFalse(r2.contains(Range32(25, 25)));
			Assert::IsFalse(r2.contains(Range32(26, 26)));

			Assert::IsFalse(Range32(19, 19).contains(r2));
			Assert::IsFalse(Range32(20, 20).contains(r2));
			Assert::IsFalse(Range32(21, 21).contains(r2));
			Assert::IsFalse(Range32(22, 22).contains(r2));
			Assert::IsFalse(Range32(23, 23).contains(r2));
			Assert::IsFalse(Range32(24, 24).contains(r2));
			Assert::IsFalse(Range32(25, 25).contains(r2));
			Assert::IsFalse(Range32(26, 26).contains(r2));
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

				success = false;
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

				try {
					a.doUnion(b);
					Assert::Fail();
				}
				catch (std::runtime_error) {
					
				}
				try {
					b.doUnion(a);
					Assert::Fail();
				}
				catch (std::runtime_error) {

				}
				try {
					Range32(a).merge(b);
					Assert::Fail();
				}
				catch (std::runtime_error) {

				}
				try {
					Range32(b).merge(a);
					Assert::Fail();
				}
				catch (std::runtime_error) {

				}
				
				temp = a.tryUnion(b, success);
				Assert::IsFalse(success);
				Assert::AreEqual(Range32(), temp);
				success = true;
				temp = b.tryUnion(a, success);
				Assert::IsFalse(success);
				Assert::AreEqual(Range32(), temp);

				success = true;
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

		TEST_METHOD(InnerRangeTest)
		{
			const auto testGoodPair = [](const Range32& a, const Range32& b, const Range32& output)
			{
				bool success = false;
				Range32 temp{};
				Assert::AreEqual(output, a.innerRange(b));
				Assert::AreEqual(output, b.innerRange(a));
				
				temp = a.tryInnerRange(b, success);
				Assert::IsTrue(success);
				Assert::AreEqual(output, temp);
				success = false;
				temp = b.tryInnerRange(a, success);
				Assert::IsTrue(success);
				Assert::AreEqual(output, temp);
			};

			const auto testBadPair = [](const Range32& a, const Range32& b)
			{
				bool success = true;
				Range32 temp{};
				
				temp = a.tryInnerRange(b, success);
				Assert::IsFalse(success);
				Assert::AreEqual(Range32(), temp);
				success = true;
				temp = b.tryInnerRange(a, success);
				Assert::IsFalse(success);
				Assert::AreEqual(Range32(), temp);

				try {
					a.innerRange(b);
					Assert::Fail();
				}
				catch (std::runtime_error) {

				}
				try {
					b.innerRange(a);
					Assert::Fail();
				}
				catch (std::runtime_error) {

				}
			};

			// Adjacent ranges
			const Range32 r1{ 5, 20 }, r2{ 20, 25 }, r_zero{ 20, 20 };
			testGoodPair(r1, r2, r_zero);
			testGoodPair(r1, r_zero, r_zero);
			testGoodPair(r2, r_zero, r_zero);

			// Self-comparisons.
			testBadPair(r1, r1);
			testBadPair(r2, r2);
			testGoodPair(r_zero, r_zero, r_zero);

			// Overlapping ranges (with r2)
			const Range32 overlap1{ 5, 22 }, overlap2{ 20, 28 };
			const Range32 inside{ 21, 25 }, inside_zero{ 22, 22 };
			testBadPair(r2, overlap1);
			testBadPair(r2, overlap2);
			testBadPair(r2, inside);
			testGoodPair(r2, inside_zero, inside_zero);

			// Disjoint ranges (with r2)
			const Range32 higher{ 30, 32 }, lower{ 1, 2 }, higher_zero{ 40, 40 };
			testGoodPair(r2, higher, Range32(25, 30));
			testGoodPair(r2, lower, Range32(2, 20));
			testGoodPair(r2, higher_zero, Range32(25, 40));
		}

		TEST_METHOD(OuterRangeTest)
		{
			// Adjacent ranges
			Range32 r1{ 5, 20 }, r2{ 20, 25 }, r_zero{ 20, 20 };
			Assert::AreEqual(Range32(5, 25), r1.outerRange(r2));
			Assert::AreEqual(Range32(5, 25), r2.outerRange(r1));
			Assert::AreEqual(r1, r1.outerRange(r_zero));
			Assert::AreEqual(r1, r_zero.outerRange(r1));
			Assert::AreEqual(r2, r2.outerRange(r_zero));
			Assert::AreEqual(r2, r_zero.outerRange(r2));

			// Self-comparisons.
			Assert::AreEqual(r_zero, r_zero.outerRange(r_zero));
			Assert::AreEqual(r1, r1.outerRange(r1));
			Assert::AreEqual(r2, r2.outerRange(r2));

			// Overlapping ranges (with r2)
			Range32 overlap1{ 5, 22 }, overlap2{ 20, 28 };
			Range32 inside{ 21, 25 }, inside_zero{ 22, 22 };
			Assert::AreEqual(Range32(5, 25), r2.outerRange(overlap1));
			Assert::AreEqual(Range32(5, 25), overlap1.outerRange(r2));
			Assert::AreEqual(Range32(20, 28), r2.outerRange(overlap2));
			Assert::AreEqual(Range32(20, 28), overlap2.outerRange(r2));
			Assert::AreEqual(r2, r2.outerRange(inside));
			Assert::AreEqual(r2, inside.outerRange(r2));
			Assert::AreEqual(r2, r2.outerRange(inside_zero));
			Assert::AreEqual(r2, inside_zero.outerRange(r2));

			// Disjoint ranges (with r2)
			Range32 higher{ 30, 32 }, lower{ 1, 2 }, higher_zero{ 40, 40 };
			Assert::AreEqual(Range32(20, 32), r2.outerRange(higher));
			Assert::AreEqual(Range32(20, 32), higher.outerRange(r2));
			Assert::AreEqual(Range32(1, 25), r2.outerRange(lower));
			Assert::AreEqual(Range32(1, 25), lower.outerRange(r2));
			Assert::AreEqual(Range32(20, 40), r2.outerRange(higher_zero));
			Assert::AreEqual(Range32(20, 40), higher_zero.outerRange(r2));
		}

		TEST_METHOD(FromLengthTest)
		{
			Assert::AreEqual(Range32(20, 25), rangeFromLength<uint32_t>(20, 5));
			Assert::AreEqual(Range32(20, 20), rangeFromLength<uint32_t>(20, 0));
			Assert::AreEqual(Range<uint8_t>(200, 255), rangeFromLength<uint8_t>(200, 55));
			Assert::AreEqual(Range<int8_t>(-5, 7), rangeFromLength<int8_t>(-5, 12));
			Assert::AreEqual(Range<int8_t>(-5, 127), rangeFromLength<int8_t>(-5, 132));
			Assert::AreEqual(Range<int8_t>(-128, 127), rangeFromLength<int8_t>(-128, 255));

			try {
				rangeFromLength<int8_t>(-100, 250);
				Assert::Fail();
			}
			catch (std::runtime_error) {

			}

			try {
				rangeFromLength<int8_t>(-5, 133);
				Assert::Fail();
			}
			catch (std::runtime_error) {

			}
		}
	};
}