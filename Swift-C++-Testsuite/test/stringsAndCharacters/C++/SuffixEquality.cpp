#include<string>
#include <string_view>

int main() {
    
    std::string_view greeting("hello there");
    std::string_view isSuffix("there");
    std::string_view notSuffix("hello");
    bool t = isSuffix == greeting.substr(greeting.length()-isSuffix.size(), isSuffix.size());
    bool f = notSuffix == greeting.substr(greeting.length()-notSuffix.size(), notSuffix.size());

    return 0;
}