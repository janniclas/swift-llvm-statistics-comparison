
 #include <iostream>
 
 struct MyMain {
     
     static int main(){
         // The code of this method can't be directly placed inside
         // the main function or it would be removed by the compiler
         // and replaced by the result.
         int result = simpleMul(21);
 
         return result;
     }
 
     // We need to store, return, or use the result of the mulition to keep
     // the compiler to remove it during optimization.
     static int simpleMul(int x){
         int a = x;
         int b = a * 2;
         return b;
     }
 };
 
 int main(){
     int result = MyMain::main();
     
     std::cout << result << std::endl;
 
     return 0;
 }