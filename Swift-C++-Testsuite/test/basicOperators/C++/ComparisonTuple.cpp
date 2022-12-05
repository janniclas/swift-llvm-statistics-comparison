#include <iostream>
#include <string>
#include <tuple>

int main() {
    bool a = std::make_tuple(41, "zebra") < std::make_tuple(42, "apple");
    bool b = std::make_tuple(3, "apple") < std::make_tuple(3, "bird");
    bool c = std::make_tuple(4, "dog") == std::make_tuple(4, "dog");

    return 0;
}
