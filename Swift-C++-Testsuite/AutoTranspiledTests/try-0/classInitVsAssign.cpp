
 #include <iostream> 
 #include <cstdlib> 

class SomeClass {
    std::string text;
public:
    SomeClass(std::string t) : text(t) {};
    void ask() {
        std::cout << text << std::endl;
    }
};

void testDI(bool cond) {
    SomeClass c;
    if (cond) {
        c = SomeClass("12345");
    }
    
    c = SomeClass("6789");  // init or assign?

    c.ask();
}

struct MyMain {

    static void main() {
        testDI(rand() % 100 > 50);
    }
};

int main(){ 
    MyMain::main(); 
}