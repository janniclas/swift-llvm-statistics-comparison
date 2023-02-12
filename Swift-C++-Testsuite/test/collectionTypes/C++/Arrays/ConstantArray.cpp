
#include <array>
#include <string>
int main()
{
    std::array<void*, 0> emptyArrayNoType; // in Swift this is an Any type
    std::array<int, 0> emptyArray;  

    int intArray[5] = {1, 2, 3, 4, 5};  // Create an array of integers with initial values

    std::array<std::string, 2> stringArray = {"Test", "Input"};  // Create an array of strings with initial values
}
