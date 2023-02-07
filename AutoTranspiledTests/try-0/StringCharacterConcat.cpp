
#include <iostream>

using namespace std;

struct MyMain {
    static void main() {
        string welcome = "Hello There";
        char exclamationMark = '!';
        welcome.append(&exclamationMark);
    }
};

int main() {
    MyMain::main();
    return 0;
}