// @main
// struct MyMain {

//     static func main() {
//         let greeting = "hello there"
//         let t = greeting.hasSuffix("there")
//         let f = greeting.hasSuffix("!")
//     }
// }

#include<string>
#include <string_view>
int main() {
    
    std::string_view greeting("Hello There");
    std::string_view isSuffix("There");
    std::string_view notSuffix("Hello");
    bool t = isSuffix == greeting.substr(greeting.length()-isSuffix.size(), isSuffix.size());
    bool f = notSuffix == greeting.substr(greeting.length()-notSuffix.size(), notSuffix.size());

    return 0;
}