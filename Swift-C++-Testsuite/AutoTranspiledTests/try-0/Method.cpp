
 #include <iostream>
 
struct MyMain {
    static void main() {
        repetitions(3, [](){
            std::cout << "Hello!" << std::endl;
        });
    }
};
 
template<typename Func>
void repetitions(int times, Func const& f) {
    for(int i = 0; i < times; i++) {
        f();
    }
}

int main() {
    MyMain::main();
    return 0;
}