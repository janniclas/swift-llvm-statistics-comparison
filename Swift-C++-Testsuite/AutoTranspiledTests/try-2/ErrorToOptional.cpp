
#include <exception>
#include <iostream> 
using namespace std;

struct MyMain {

    static void main() {
        int someThrowingFunction() throw(exception) {
            // ...
            return 42;
        }

        int x = try ? someThrowingFunction();

        int y;
        try {
            y = someThrowingFunction();
        } catch(exception &ex) {
            y = nullptr ;
        }
    }

};

int main() {
   MyMain::main();
   return 0;
}