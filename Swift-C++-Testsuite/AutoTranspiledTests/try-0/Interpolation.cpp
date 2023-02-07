 
#include <iostream>
#include <string>

int main()
{
    int multiplier = 3;
    std::string message = std::to_string(multiplier) + " times 2.5 is " + std::to_string(multiplier * 2.5);
    
     // message is "3 times 2.5 is 7.5"
    std::cout << message << std::endl;
    return 0;
}