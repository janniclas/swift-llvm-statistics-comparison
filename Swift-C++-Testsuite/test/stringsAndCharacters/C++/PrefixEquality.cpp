// @main
// struct MyMain {

//     static func main() {
//         let greeting = "hello there"
//         let t = greeting.hasPrefix("hello")
//         let f = greeting.hasPrefix("there")
//     }
// }
#include<string>
#include <string_view>
int main() {
    
    std::string_view greeting("Hello There");
    std::string_view notPrefix("here");
    std::string_view isPrefix("Hello");
    bool t = isPrefix == greeting.substr(0, isPrefix.size());
    bool f = notPrefix == greeting.substr(0, notPrefix.size());


    return 0;
}