
#include <iostream> 
using namespace std; 
 
struct MyMain { 
  
    static int main() 
    { 
        int myRes = identity(42); 
        return 0;  
    } 
    static int identity(int x) 
    { 
        return x; 
    } 
}; 
  
// Main function 
int main() 
{ 
    MyMain::main(); 
}