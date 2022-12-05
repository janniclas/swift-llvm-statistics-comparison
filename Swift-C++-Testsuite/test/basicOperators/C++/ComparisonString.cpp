#include <string>

bool stringEqual(std::string x) {
    bool tmp = x == "Hello";
    return tmp;
}

bool stringNotEqual(std::string x) {
    bool tmp = x != "Hello";
    return tmp;
}
bool stringLarger(std::string x) {
    bool tmp = x > "Hello";
    return tmp;
}
bool stringSmaller(std::string x) {
    bool tmp = x < "Hello";
    return tmp;
}
bool stringLargerOrEqual(std::string x) {
    bool tmp = x >= "Hello";
    return tmp;
}
bool stringSmallerOrEqual(std::string x) {
    bool tmp = x <= "Hello";
    return tmp;
}

int main() {
    bool a1 = stringEqual("Hello");
    bool a2 = stringEqual("World");
    bool b1 = stringNotEqual("Hello"); // false
    bool b2 = stringNotEqual("World"); // true
    bool c1 = stringLarger("Hello"); // true
    bool c2 = stringLarger("World"); //false
    bool d1 = stringSmaller("Hello"); // true
    bool d2 = stringSmaller("World"); // false
    bool e1 = stringLargerOrEqual("Hello"); // true
    bool e2 = stringLargerOrEqual("World"); // false
    bool f1 = stringSmallerOrEqual("Hello"); // true
    bool f2 = stringSmallerOrEqual("World"); // false
}
