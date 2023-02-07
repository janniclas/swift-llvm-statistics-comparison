
#include <iostream>
 
int identity(int x);
 
int main() {
    int myRes = identity(42);
    return 0;
}
 
int identity(int x) {
    return x;
}