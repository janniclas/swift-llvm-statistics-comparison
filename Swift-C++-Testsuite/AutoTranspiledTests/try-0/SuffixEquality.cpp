
 #include <iostream>
 #include <string>

 int main() {
    std::string greeting = "hello there";
    bool t = (greeting.find("there") == (greeting.length() - 5)); 
    bool f = (greeting.find("!") == (greeting.length() - 1)); 
 }