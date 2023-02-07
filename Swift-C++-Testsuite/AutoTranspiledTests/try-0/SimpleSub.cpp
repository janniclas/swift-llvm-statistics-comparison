
#include <iostream>

int simpleSub(int x) {
    int a = x;
    int b = a - 41;
    return b;
}

int main() {
    int result = simpleSub(1);
    std::cout << result << std::endl;
    return 0; 
}