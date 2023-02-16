
#include <iostream>

struct MyMain {
    static void main() {
    	paramNoReturn(42);
    }
    
    static void paramNoReturn(int x) {
    	int a = 5;
    	int b = 10;
    	int c = a + b + x;
    }
};

int main() {
    MyMain::main();
    return 0;
}