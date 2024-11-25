#include "funca.h"
#include <cmath>

double FuncA::calculate(int n) {
    double result = 0.0;
    for (int i = 0; i < n; ++i) {
        result += pow(-1, i) * (pow(2 * i, 2)) / (pow(2 * i + 1, 2)); // Формула
    }
    return result;
}

