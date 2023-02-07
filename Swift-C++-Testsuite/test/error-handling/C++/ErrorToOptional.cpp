#include <iostream> 
using namespace std;

        static int someThrowingFunction() noexcept(false) {
            // ...
            return 42;
        }

int main() {

        int y;
        try {
            y = someThrowingFunction();
        } catch(exception &ex) {
            y = -1;
        }
    }

