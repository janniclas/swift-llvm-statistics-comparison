 
#include <iostream>

 using namespace std;
 
struct Fibonacci {

    static void Main() {
        int lim = 5;
        int a = 0;
        int b = 1;
        while (b < lim) {
            cout << b << endl;
            a = b;
            b = a + b;
        }
    }
};

int main() {
    Fibonacci::Main();
    return 0;
}