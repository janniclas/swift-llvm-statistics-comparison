
#include <iostream>

void swapTwoInts(int* a, int* b) {
    int tempA = *a;
    *a = *b;
    *b = tempA;
}
int main()
{
    int someInt = 3;
    int anotherInt = 107;
    swapTwoInts(&someInt, &anotherInt);

    return 0;
}