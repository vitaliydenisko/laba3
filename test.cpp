#include <gtest/gtest.h>
#include "funca.h"

TEST(FuncATest, SimpleTest) {
    FuncA func;
    EXPECT_EQ(func.calculate(3), 1); // Змінити на очікуване значення
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

