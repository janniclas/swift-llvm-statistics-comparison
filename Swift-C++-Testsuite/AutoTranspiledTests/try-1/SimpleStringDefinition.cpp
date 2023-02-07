
#include <iostream>

using namespace std;

struct MyMain {

    static void main() {
        string greeting = "Hello World!";
    }
};

int main()
{
    MyMain::main();
    return 0;
}