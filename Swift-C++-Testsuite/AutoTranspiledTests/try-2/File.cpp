
#include <iostream>

struct MyMain {

    static void main() {
        auto incrementer = [](int x) { return x + 5; };
        void explicitClosure(int(myFunction)(int)){
            myFunction(5);
        };
        explicitClosure(incrementer);
        explicitClosure([](int x) { return x + 5; });
    }
};

int main()
{
    MyMain::main();
}