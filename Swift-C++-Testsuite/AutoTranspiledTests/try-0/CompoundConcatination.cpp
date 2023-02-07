
#include <iostream>

struct MyMain
{
  static void main()
  {
    std::string greetingPartOne = "Hello";
    std::string greetingPartTwo = " World!";
    greetingPartOne += greetingPartTwo;
  }

};

int main()
{
    MyMain::main();
    return 0;
}