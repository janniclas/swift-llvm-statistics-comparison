

#include <iostream>

int implicitReturn(int x) {
    return x;
}

int main() {
    std::cout << implicitReturn(42) << std::endl;
}