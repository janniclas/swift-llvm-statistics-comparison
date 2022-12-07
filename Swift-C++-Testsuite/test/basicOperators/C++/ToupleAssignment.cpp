#include <tuple>

int main() {
    std::tuple<int, int> b = std::make_tuple(1, 2);
    std::tuple<int, int> a = std::make_tuple(1, 2);
    a = b;
}