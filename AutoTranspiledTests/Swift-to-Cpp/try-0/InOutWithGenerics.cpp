
#include <iostream>
#include <string>
    
template<typename T>
void swapTwoValues(T* a, T* b) {
    T tempA = *a;
    *a = *b;
    *b = tempA;
}

int main() {
    int x = 42;
    int y = 24;
    swapTwoValues(&x, &y);
    // std::cout << "x: " << x << " y: " << y << std::endl;
    std::string z = "World";
    std::string i = "Hello";
    swapTwoValues(&z, &i);
    // std::cout << z + i << std::endl;

    return 0;
}