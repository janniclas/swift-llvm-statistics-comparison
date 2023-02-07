
#include <iostream>

struct MyMain
{
    static int main()
    {
        int res = switchMe(2, 3);
    }

    static int switchMe(int x, int y)
    {
        int counter = 0;
        int max = 7;

        switch(x, y)
        {
        case (x, y):
            counter = 100;
            //fallthrough
        case (0, y):
            counter = -y;
        case (x, y):
            counter = -x;
        default:
            counter = 42;
        }
        return counter;
    }
};

int main()
{
    MyMain::main();
    return 0;
 }