
#include <iostream>

struct MyMain {
    static void main() {
        bool a = (41, "zebra") < (42, "apple"); // true because 1 is less than 2; "zebra" and "apple" aren't compared
        bool b = (3, "apple") < (3, "bird"); // true because 3 is equal to 3, and "apple" is less than "bird"
        bool c = (4, "dog") == (4, "dog"); // true because 3 is equal to 3, and "dog" is equal to "dog"

        std::cout << a << b << c << std::endl;
    }
};

int main() {
    MyMain::main();
    return 0;
}