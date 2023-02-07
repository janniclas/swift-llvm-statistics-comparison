
#include <iostream>
using namespace std;
 
int noParamNoReturn() 
{ 
    int a = 5;
    int b = 10;
    int c = a + b;
    
    return c;
} 
  
int main() 
{ 
    noParamNoReturn();
    
    return 0;
}