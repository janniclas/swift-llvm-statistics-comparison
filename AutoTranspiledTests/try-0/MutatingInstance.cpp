
#include <iostream>

struct MyMain 
{
    static void main() 
    {
        int someInt = 3;
        someInt = square(someInt);
    }
};

int square(int x)
{
   return x * x;
}
int main() 
{
    MyMain::main();
    return 0;
}