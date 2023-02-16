
#include <iostream>

struct MyMain {

    static void main() {
        // This call would crash with a normal add.
        // returns -9223372036854775808
        int a = subWithOverflow(std::numeric_limits<int>::min());
    }

    // The & sign turns an subition to an substraction without overflow
    static int subWithOverflow(int x) {
        int tmp = x &- 1;
        return tmp;
    }
};

int main() {
    MyMain::main();

    return 0;
}