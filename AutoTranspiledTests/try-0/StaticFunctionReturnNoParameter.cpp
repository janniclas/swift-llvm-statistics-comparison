
#include <iostream>
 
struct MyMain
{
    static int main()
    {
        int myRes = noParamWithReturn();
        return 0;
    }
    static int noParamWithReturn()
    {
        int a = 5;
        int b = 10;
        int c = a + b;
        return c;
    }
};
 
int main()
{
    MyMain::main();
    return 0;
}