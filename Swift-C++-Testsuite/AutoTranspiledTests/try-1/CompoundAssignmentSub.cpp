
#include <iostream>

int CompoundAssignment(int x) 
{
  int a = x;
  a -= 42;
  return a;
}

int main() 
{
  std::cout << CompoundAssignment(-1) << std::endl;
  return 0;
}