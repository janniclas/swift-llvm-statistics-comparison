
 
struct MyMain {

public:
    int access;

    static void main() {
        std::map<int, int> namesOfIntegers = {
            {5, 32}, {4, 42}
        };
        access = namesOfIntegers[4];
    }
};

int main() {
    MyMain::main();

    return 0;
}