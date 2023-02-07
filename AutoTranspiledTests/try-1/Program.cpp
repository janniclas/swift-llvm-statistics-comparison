
#include <iostream>

int add(int z) {
    int a = 78092178;
    int b = 45124;
    int x = a + b;

    return x + z;
}

int magic(int q, int w) {
    int tmp = q + w;
    return tmp;
}

int main() {
    int z = add(1234);
    std::cout << magic(12345, 123456) << std::endl;


    return 0;
}