
 #include <iostream>
#include <string>

using namespace std;

int main() {
    string greeting = "Hello There";
    bool notPrefix = greeting.find("here") == 0;
    bool isPrefix = greeting.find("Hello") == 0;
    return 0;
}