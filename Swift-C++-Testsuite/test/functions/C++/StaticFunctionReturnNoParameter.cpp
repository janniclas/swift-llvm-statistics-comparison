
#include <iostream>
 
struct MyMain
{
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
    int myRes = MyMain::noParamWithReturn();
    return 0;
}