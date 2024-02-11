#include "CppUnitTest.h"

#include "range.h"
#include "range_set.h"
#include "util.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

typedef Range<uint32_t> Range32;
typedef RangeSet<uint32_t> RangeSet32;

namespace UnitTests
{
	TEST_CLASS(RangeSetUnitTests)
	{
	public:
		TEST_METHOD(IteratorTest)
		{
			RangeSet32 empty{};
			Assert::IsTrue(empty.crangeBegin() == empty.crangeEnd());

			RangeSet32 one{};
			one.insert(Range32(5, 20));
			auto it = one.crangeBegin();
			Assert::IsTrue(it != one.crangeEnd());
			Assert::AreEqual(Range32(5, 20), *it);
			it++;
			Assert::IsTrue(it == one.crangeEnd());

			RangeSet32 three{};
			three.insert(Range32(5, 20));
			three.insert(Range32(25, 40));
			three.insert(Range32(100, 101));
			it = three.crangeBegin();
			Assert::IsTrue(it != three.crangeEnd());
			Assert::AreEqual(Range32(5, 20), *it);
			it++;
			Assert::IsTrue(it != three.crangeEnd());
			Assert::AreEqual(Range32(25, 40), *it);
			it++;
			Assert::IsTrue(it != three.crangeEnd());
			Assert::AreEqual(Range32(100, 101), *it);
			it++;
			Assert::IsTrue(it == three.crangeEnd());
		}

		TEST_METHOD(InitializerListTest)
		{
			RangeSet32 expected{};
			expected.insert(Range32(5, 20));
			expected.insert(Range32(25, 40));
			expected.insert(Range32(100, 101));


			RangeSet32 actual{ {5, 20}, {25, 40}, {100, 101} };
			Assert::AreEqual(expected, actual);

			RangeSet32 test2{ {1, 2}, {70, 87} };
			test2 = { {5, 20}, {25, 40}, {100, 101} };
			Assert::AreEqual(expected, test2);
		}

		TEST_METHOD(ContainsPointTest)
		{
			const RangeSet32 base{ {5, 20}, {25, 40}, {100, 101} };

			for (int i = 0; i < 5; i++)
			{
				std::wstring message{ L"i = " };
				message += std::to_wstring(i);
				Assert::IsFalse(base.contains(i), message.c_str());
			}

			for (int i = 5; i < 20; i++)
			{
				std::wstring message{ L"i = " };
				message += std::to_wstring(i);
				Assert::IsTrue(base.contains(i), message.c_str());
			}

			for (int i = 20; i < 25; i++)
			{
				std::wstring message{ L"i = " };
				message += std::to_wstring(i);
				Assert::IsFalse(base.contains(i), message.c_str());
			}

			for (int i = 25; i < 40; i++)
			{
				std::wstring message{ L"i = " };
				message += std::to_wstring(i);
				Assert::IsTrue(base.contains(i), message.c_str());
			}

			for (int i = 40; i < 100; i++)
			{
				std::wstring message{ L"i = " };
				message += std::to_wstring(i);
				Assert::IsFalse(base.contains(i), message.c_str());
			}

			Assert::IsTrue(base.contains(100));
			Assert::IsFalse(base.contains(101));
		}

		TEST_METHOD(ContainsRangeTest)
		{
			const RangeSet32 base{ {5, 20}, {25, 40}, {100, 101} };

			Assert::IsTrue(base.contains(Range32(5, 20)));
			Assert::IsTrue(base.contains(Range32(6, 10)));
			Assert::IsTrue(base.contains(Range32(7, 7)));
			Assert::IsTrue(base.contains(Range32(27, 40)));

			Assert::IsFalse(base.contains(Range32(25, 25)));
			Assert::IsFalse(base.contains(Range32(5, 40)));
			Assert::IsFalse(base.contains(Range32(0, 5)));
			Assert::IsFalse(base.contains(Range32(100, 102)));
		}

		TEST_METHOD(IntersectsRangeTest)
		{
			const RangeSet32 base{ {5, 20}, {25, 40}, {100, 101} };

			Assert::IsTrue(base.intersects(Range32(5, 20)));
			Assert::IsTrue(base.intersects(Range32(6, 10)));
			Assert::IsTrue(base.intersects(Range32(7, 7)));
			Assert::IsTrue(base.intersects(Range32(27, 40)));

			Assert::IsTrue(base.intersects(Range32(5, 40)));
			Assert::IsTrue(base.intersects(Range32(100, 102)));

			Assert::IsFalse(base.intersects(Range32(0, 5)));
			Assert::IsFalse(base.intersects(Range32(25, 25)));
		}

		TEST_METHOD(InsertTest)
		{
			const RangeSet32 base{ {5, 20}, {25, 40}, {100, 101} };

			const RangeSet32 e1{ { 5, 20 }, { 25, 40 }, { 100, 101 }, {200, 250} };
			RangeSet32 t1(base);
			t1.insert({ 200, 250 });
			Assert::AreEqual(e1, t1);

			const RangeSet32 e2{ {5, 20}, {25, 40}, {41, 45}, {100, 101} };
			RangeSet32 t2(base);
			t2.insert({ 41, 45 });
			Assert::AreEqual(e2, t2);

			const RangeSet32 e3{ {1, 3}, {5, 20}, {25, 40}, {100, 101} };
			RangeSet32 t3(base);
			t3.insert({ 1, 3 });
			Assert::AreEqual(e3, t3);			

			const RangeSet32 e4{ {5, 40}, {100, 101} };
			RangeSet32 t4(base);
			t4.insert({ 20, 33 });
			Assert::AreEqual(e4, t4);

			const RangeSet32 e5{ {3, 200} };
			RangeSet32 t5(base);
			t5.insert({ 3, 200 });
			Assert::AreEqual(e5, t5);

			RangeSet32 t6(base);
			t6.insert({ 6, 10 });
			Assert::AreEqual(base, t6);

			t6.insert({ 25, 30 });
			Assert::AreEqual(base, t6);

			t6.insert({ 23, 23 });
			Assert::AreEqual(base, t6);

			t6.insert({ 7, 7 });
			Assert::AreEqual(base, t6);

			const RangeSet32 e7{ {3, 20}, {25, 40}, {100, 101} };
			RangeSet32 t7(base);
			t7.insert({ 3, 5 });
			Assert::AreEqual(e7, t7);

			const RangeSet32 e8{ {5, 24}, {25, 40}, {100, 101} };
			RangeSet32 t8(base);
			t8.insert({ 20, 24 });
			Assert::AreEqual(e8, t8);

			const RangeSet32 e9{ {5, 20}, {22, 40}, {100, 101} };
			RangeSet32 t9(base);
			t9.insert({ 22, 25 });
			Assert::AreEqual(e9, t9);

			const RangeSet32 e10{ {5, 20}, {25, 40}, {100, 104} };
			RangeSet32 t10(base);
			t10.insert({ 101, 104 });
			Assert::AreEqual(e10, t10);
		}

		TEST_METHOD(FindRangeContainingTest)
		{
			std::vector<Range32> ranges{ {2, 4}, {6, 8}, {10, 12} };
			const auto it_2_4 = ranges.cbegin();
			const auto it_6_8 = it_2_4 + 1;
			const auto it_10_12 = it_6_8 + 1;
			const auto it_end = ranges.cend();

			const std::vector<Range32>::const_iterator expected[] = {
				it_2_4, // 0
				it_2_4, // 1
				it_2_4, // 2
				it_2_4, // 3
				
				it_6_8, // 4
				it_6_8, // 5
				it_6_8, // 6
				it_6_8, // 7
				
				it_10_12, // 8
				it_10_12, // 9
				it_10_12, // 10
				it_10_12, // 11

				it_end, // 12
				it_end, // 13
				it_end // 14
			};

			for (uint32_t i = 0; i < 14; i++) {
				auto it_actual = _range_helpers::find_range_containing(ranges, i);
				auto it_expected = expected[i];
				std::wstring message{ L"i = " };
				message += std::to_wstring(i);
				Assert::IsTrue(it_actual == it_expected, message.c_str());
			}
		}

		TEST_METHOD(FindInsertionPointTest)
		{
			std::vector<Range32> ranges{ {2, 4}, {6, 8}, {10, 12} };
			const auto it_2_4 = ranges.cbegin();
			const auto it_6_8 = it_2_4 + 1;
			const auto it_10_12 = it_6_8 + 1;
			const auto it_end = ranges.cend();

			// Expected results for Range32(i, i+n) for any n
			const std::vector<Range32>::const_iterator expected[] = {
				it_2_4, // 0
				it_2_4, // 1
				it_2_4, // 2
				it_2_4, // 3
				it_2_4, // 4

				it_6_8, // 5
				it_6_8, // 6
				it_6_8, // 7
				it_6_8, // 8

				it_10_12, // 9
				it_10_12, // 10
				it_10_12, // 11
				it_10_12, // 12

				it_end, // 13
				it_end // 14
			};

			for (uint32_t i = 0; i < 14; i++) {
				const auto it_expected = expected[i];
				// Results should not depend on length.
				for (uint32_t len = 0; len < 5; len++)
				{
					const Range32 currentRange{ i, i + 1 };
					auto it_actual = _range_helpers::find_location_for_range(ranges, currentRange);
					std::wstring message{ L"i=" };
					message += std::to_wstring(i);
					message += L", len=";
					message += std::to_wstring(len);
					Assert::IsTrue(it_actual == it_expected, message.c_str());
				
					if (it_actual != ranges.cbegin())
					{
						Assert::IsFalse((it_actual - 1)->canMerge(currentRange), message.c_str());
					}
				}
			}
		}
	};
}