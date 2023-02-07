
#include <iostream>

struct MyMain {

    static void main() {
        std::cout << unaryPlus(x: -1);
    }

    // Documentation states the following
    // The unary plus operator (+) simply returns the value it operates on, without any change
    static int unaryPlus(int x) {
        int a = x;
        int b = +a;
        return b;
    }
};

int main() {
    MyMain::main();
    return 0;
}