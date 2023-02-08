using namespace std;
 
 struct MyMain {
     static int identity(int x, bool t) {
         if (t) {
             return x;
         } else {
             return -x;
         }
     }
 };
 
 int main() {
         int myRes = MyMain::identity(42, true);
     return 0;
 }