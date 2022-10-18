
// @main
// struct MyMain {

//     static func main() {
//         var welcome = "hello there"
//         let exclamationMark: Character = "!"
//         welcome.append(exclamationMark)

//     }
// }
#include <string>
#include <iostream>
int main() {
    std::string welcome("Hello There");
    char exclamationMark = '!';
    welcome.append(1, exclamationMark);
    std::cout << welcome;
    return 0;
}
