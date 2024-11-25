#include <iostream>
#include "funca.h"

int main() {
    FuncA func;
    int n = 5; // Приклад значення
    std::cout << "Result: " << func.calculate(n) << std::endl;
    return 0;
}

