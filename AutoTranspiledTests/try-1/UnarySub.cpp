
#include <iostream>
 
struct MyMain {
 
    static void main(){
        std::cout << unaryMinus(-1) << std::endl;
    }
 
    // The unary minus operator (-) inverts the current sign.
    // It performs the sign switch by calculating 0 - x
    static int unaryMinus(int x) {
        int a = x;
        int b = 0 - a;
        return b;
    }
};
 
int main(){
    MyMain::main();
}