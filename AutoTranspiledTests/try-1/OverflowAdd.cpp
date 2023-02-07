

#include <iostream>

struct MyMain {
    static void main() {
        // This call would crash with a normal add.
        // returns -9223372036854775808
        int result = addWithOverflow(std::numeric_limits<int>::max(), 1);
    }

    // The & sign turns an addition to an addition without overflow
    static int addWithOverflow(int x, int y) {
        int tmp = x &+ y;
        return tmp;
    }
};

int main() {
    MyMain::main();
    return 0;
}