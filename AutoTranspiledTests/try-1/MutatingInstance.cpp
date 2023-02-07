
 #include <iostream>
 
 struct MyMain {
 
     static void main() {
         int someInt = 3;
         someInt.square();
     }
 };
 
 struct Int {
     static void square(int& n){
         n = n * n;
     }
 };
 
 int main(){
    MyMain::main();
    return 0;
 }