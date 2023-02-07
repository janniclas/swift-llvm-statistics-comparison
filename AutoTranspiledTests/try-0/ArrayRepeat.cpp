
#include <iostream>
using namespace std;

struct MyMain {
    static void main(){
        int a[3] = {0};
    }
};

int main(){
    MyMain::main();
    return 0;
}