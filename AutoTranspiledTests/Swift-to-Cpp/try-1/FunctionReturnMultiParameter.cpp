
#include <iostream>
 
struct MyMain {
  static void main() {
   int myRes = identity(42, true);
  }
};
 
int identity(int x, bool t) {
    if (t) {
        return x;
    } else {
        return -x;
    }
}
 
int main() {
    MyMain::main();
    return 0;
}