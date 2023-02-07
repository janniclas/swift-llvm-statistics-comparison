 
#include <iostream> 

struct MyMain {

    static void main() {
        // The code of this method can't be directly placed inside
        // the main function or it would be removed by the compiler
        // due to mandatory optimizations.
        int _ = simpleAdd(1); 
    }

    static int simpleAdd(int x) {
        int a = x;
        int b = a+ 41;
        return b;  
    }
}; 

int main() {
    MyMain::main(); 
    return 0; 
}