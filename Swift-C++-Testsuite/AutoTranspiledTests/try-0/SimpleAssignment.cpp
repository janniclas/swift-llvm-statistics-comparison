
#include <iostream>
struct simpleAssignment {

    static void main() {
        int b = 10;
        int a = 5;
        a = b;
   }
};

int main() {
    simpleAssignment::main();
    return 0;
}