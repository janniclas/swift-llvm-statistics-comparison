#include <string.h>
#include <iostream>

 
int main()
{
    // Take any string
    std::string greeting = "Hello, world!";
    
    size_t index = greeting.find_last_of(",");
    // Copy two characters of s1 (starting
    // from position 3)
    std::string beginning = greeting.substr(0, index);
 
    return 0;
}