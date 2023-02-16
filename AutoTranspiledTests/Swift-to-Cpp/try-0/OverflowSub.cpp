 
#include <iostream>
 
struct MyMain{
   static int subWithOverflow(int x) {
        int tmp = x & -1; 
        return tmp;
    }
   
    static void main(){
        // This call would crash with a normal add. 
        //returns -9223372036854775808 
        int a = subWithOverflow(x: INT_MIN); 
    }

};
  
int main(){
    MyMain::main();
}