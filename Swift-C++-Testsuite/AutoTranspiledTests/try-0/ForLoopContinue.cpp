
#include <iostream>

int main()
{
    int counter = 0;
    for (int a = 0; a < 11; a++){
        if (a % 2 == 0)
            continue;
        counter++;
    }
    return 0;

}