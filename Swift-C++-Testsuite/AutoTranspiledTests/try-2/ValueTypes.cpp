
#include<iostream>
#include<string>

struct MyMain {
    
    static std::string takeStringMutateGiveString(std::string input) {
        std::string m = input;
        m += " Awesome Day.";
        return m;
    }

    static std::string takeStringGiveString(std::string input) {
        std::string copied = input;
        return copied;
    }

    static std::string identity(std::string input) {
        return input;
    }

    static void main() {
        // search builtinStringLiteral.* in swift repository
        // sSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC
        std::string greeting = "Hello World!";
        std::string a = takeStringGiveString(greeting);
        std::string b = takeStringMutateGiveString(greeting);
        std::string c = identity(greeting);
    }

};

int main() {
    MyMain::main();
    return 0;
}