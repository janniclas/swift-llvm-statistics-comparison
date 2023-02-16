
 #include <cstdint>

int addWithOverflow(int x, int y) {
    int tmp = x &+ y;
    return tmp;
}

int main() {
    // This call would crash with a normal add.
    // returns -9223372036854775808
    int result = addWithOverflow(INT_MAX, 1);
    return 0;
    
}