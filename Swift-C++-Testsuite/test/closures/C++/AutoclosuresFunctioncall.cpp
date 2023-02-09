
#include <vector>

int main() {
        std::vector<int> customersInLine = {1, 2, 3, 4, 5, 6, 42};

        auto serve = [](auto customerProvider) {
            auto tmp = customerProvider();
        };

        serve([&]() {
            return customersInLine.erase(customersInLine.begin());
        });
    return 0;
}
