
#include <iostream>
#include <string>

struct Resolution {
    int width;
    int height;
};

std::string toString(Resolution res) {
    std::string width = std::to_string(res.width);
    std::string height = std::to_string(res.height);
    return "The resolution is " + width + "x" + height;
}

int main() {
    Resolution res = {1920, 1080};
    std::cout << toString(res);
    return 0;
}