
#include <iostream>
 
int switchMe(int x, int y);
 
struct MyMain {
    public static void main() {
        int res = switchMe(2, 3);
    }
 
};
 
int switchMe(int x, int y) {
    int counter = 0;
    int max = 7;
    switch(x) {
        case 1: 
            if (y == 1) {
                counter = max;
            }
            else {
                counter = -max;
            }
            break;
        case 0:
            counter = -max;
            break;
        default:
            counter = 42;
            break;
    }
    return counter;
}