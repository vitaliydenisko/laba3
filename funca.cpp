#include "funca.h"
#include <cmath>

// calculate - функція для обчислення суми перших n елементів ряду
// n - кількість елементів для обчислення
double FuncA::calculate(int n) {
    double result = 0.0;
    for (int i = 0; i < 3; ++i) { // Лише перші 3 елементи
    for (int i = 0; i < n; ++i) {
        result += pow(-1, i) * (pow(2 * i, 2)) / (pow(2 * i + 1, 2));
    }
    return result;
}

