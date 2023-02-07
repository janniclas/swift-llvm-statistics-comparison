
#include <iostream>

class MyMain {
public:
    static void main(){
        int someInt = 3;
        someInt.square();
    }
};

class Int {
public:
     int x;
     void square(){
        x = x * x;
     }
};

int main(){
    MyMain::main();
    return 0;
}