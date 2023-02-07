
#include <iostream>
#include <random>
#include <string>

class SomeClass
{
public:
  std::string text;
  SomeClass(std::string text)
  {
    this->text = text;
  }
  void ask()
  {
    std::cout << text << std::endl;
  }
};

void testDI(bool cond)
{
  SomeClass c;
  if(cond)
  {
    c = SomeClass("12345");
  }

  c = SomeClass("6789"); //init or assign?

  c.ask();

}

struct MyMain
{
  static void main()
  {
    std::random_device rd; 
    std::mt19937 rng(rd());
    std::uniform_int_distribution<int> uniform_dist(1, 99);
    testDI(uniform_dist(rng) > 50);
  }
};

int main()
{
  MyMain::main();
}