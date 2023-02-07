
#include <iostream>
 using namespace std;
 
 struct MyMain {
     static int main() {
         int myRes = identity(42, true);
         return 0;
     }
     static int identity(int x, bool t) {
         if (t) {
             return x;
         } else {
             return -x;
         }
     }
 };
 
 int main() {
     MyMain::main();
     return 0;
 }