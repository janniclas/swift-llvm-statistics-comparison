
 struct MyMain {
 
    static void main() {
        int counter = 0;
        int max = 7;
        while (counter < max) {
            counter += 1;
        }
    }
};

int main() {
    MyMain::main();
    return 0;
}