#include <string>

std::string identity(std::string input) {
return input;
}

std::string takeStringGiveString(std::string input) {
std::string copied = input;
return copied;
}
std::string takeStringMutateGiveString(std::string input) {
std::string m = input;
m += " Awesome Day.";
return m;
}

int main() {
    std::string greeting = "Hello World!";
    std::string a = takeStringGiveString(greeting);
    std::string b = takeStringMutateGiveString(greeting);
    std::string c = identity(greeting);
}
