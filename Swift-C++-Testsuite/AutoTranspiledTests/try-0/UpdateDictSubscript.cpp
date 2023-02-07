

#include<iostream>
#include<map>
using namespace std;

int main() {
  std::map<int, int> namesOfIntegers;
  namesOfIntegers[5] = 32;
  namesOfIntegers[4] = 42;
  namesOfIntegers[4] = 44;
  
  return 0;
}