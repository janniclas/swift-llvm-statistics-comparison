#include <iostream>
#include <vector>


int main() {
        std::vector<int> customersInLine = {1, 2, 3, 4, 5, 6, 42};



        auto customerProvider = [&]() {
            return customersInLine.erase(customersInLine.begin());
        };
        auto next = customerProvider();
    return 0;
}
