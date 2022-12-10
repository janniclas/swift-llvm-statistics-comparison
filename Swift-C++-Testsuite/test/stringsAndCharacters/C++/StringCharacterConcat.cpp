#include <string>

int main() {
    std::string welcome("Hello There");
    char exclamationMark = '!';
    welcome.append(1, exclamationMark);
    return 0;
}
