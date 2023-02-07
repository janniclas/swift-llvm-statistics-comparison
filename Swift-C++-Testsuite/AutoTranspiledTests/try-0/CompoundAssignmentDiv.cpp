
 #include <iostream>

struct MyMain {
    static int main() {
        return compoundAssignment(15);
    }

    // Code is semantically equivalent to the normal add test.
    // Slight difference, because it doesn't generate the llvm.lifetime
    // operations, but this shouldn't have any implications to any static
    // code analyses.
    static int compoundAssignment(int x) {
        int a = x;
        a /= 5;
        return a;
    }
};

int main() {
    return MyMain::main();
}