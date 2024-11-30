#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <chrono>
#include "funca.h" // Ваш клас для тригонометричних функцій
#include "funca.cpp"
#include "httplib.h" // HTTP бібліотека, наприклад, https://github.com/yhirose/cpp-httplib

// Обчислення тригонометричних значень і сортування
std::pair<std::vector<double>, double> calculate_and_sort(int n) {
    FuncA func;
    std::vector<double> values;

    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < n; ++i) {
        values.push_back(func.calculate(i));
    }
    std::sort(values.begin(), values.end());

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = end - start;

    return {values, elapsed.count()};
}

int main() {
    httplib::Server svr;

    svr.Get("/", [](const httplib::Request &, httplib::Response &res) {
        const int n = 100000; // Кількість елементів у масиві
        auto [sorted_values, elapsed_time] = calculate_and_sort(n);

        std::string response_body = "Elapsed time: " + std::to_string(elapsed_time) + " seconds\n";
        res.set_content(response_body, "text/plain");
    });

    std::cout << "Server is running on http://localhost:8080" << std::endl;
    svr.listen("0.0.0.0", 8080);
    return 0;
}

