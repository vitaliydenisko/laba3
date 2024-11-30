#include <iostream>
#include <cassert>
#include <chrono>
#include "funca.h"

void test_calculation_time() {
    FuncA func;
    const int n = 100000;

    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < n; ++i) {
        func.calculate(i);
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = end - start;

    assert(elapsed.count() >= 5 && elapsed.count() <= 20);
    std::cout << "Test passed! Time: " << elapsed.count() << " seconds" << std::endl;
}

int main() {
    test_calculation_time();
    return 0;
}

