
bool numberEqual(int x) {
    bool tmp = x == 42;
    return tmp;
}

bool numberNotEqual(int x) {
    bool tmp = x != 42;
    return tmp;
}
bool numberLarger(int x) {
    bool tmp = x > 42;
    return tmp;
}
bool numberSmaller(int x) {
    bool tmp = x < 42;
    return tmp;
}
bool numberLargerOrEqual(int x) {
    bool tmp = x >= 42;
    return tmp;
}
bool numberSmallerOrEqual(int x) {
    bool tmp = x <= 42;
    return tmp;
}

int main() {
    bool a1 = numberEqual(42);
    bool a2 = numberEqual(41);
    bool b1 = numberNotEqual(42); // false
    bool b2 = numberNotEqual(41); // true
    bool c1 = numberLarger(43); // true
    bool c2 = numberLarger(41); //false
    bool d1 = numberSmaller(41); // true
    bool d2 = numberSmaller(43); // false
    bool e1 = numberLargerOrEqual(42); // true
    bool e2 = numberLargerOrEqual(41); // false
    bool f1 = numberSmallerOrEqual(42); // true
    bool f2 = numberSmallerOrEqual(43); // false
}
