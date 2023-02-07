
struct MyMain {

public:
    static void main() {
        int _ = simpleReminder( 43);
    }

    // We need to store, return, or use the result of the reminder to keep
    // the compiler to remove it during optimization.
    static int simpleReminder(int x) {
        int a = x;
        int b = a % 2;
        return b;
    }
};

int main() {
MyMain::main();
return 0;
}