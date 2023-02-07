
#include <iostream>
using namespace std;

struct MyMain {

static void main() {
        auto incrementer = [=](int x) { return x + 5; }; 
        void explicitClosure(std::function<int(int)> myFunction) {
            myFunction(5);
        }
        explicitClosure(incrementer);
        explicitClosure([=](int x) { return x + 5; });
    }

};

int main() {
 MyMain::main();

 return 0;
}