#include<string>

int main() {
    char myword[] = { 'H', 'e', 'l', 'l', 'o', '\0' };
    std::string myWordString = std::string(myword);
}
