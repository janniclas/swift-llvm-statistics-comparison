 
 struct MyMain {

public:
    static int unaryMinus(int x) {
        int a = x;
        int b = 0 - a;
        return b;
    }

    static void main() {
        int a = unaryMinus(x: -1);
    }
};

int main() {
    MyMain::main();

    return 0;
}