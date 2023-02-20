#include <iostream>

auto makeIncrementer(int amount) {
  int runningTotal = 0;
  auto incrementer = [runningTotal, amount]() mutable {
    runningTotal += amount;
    return runningTotal;
  };

  return incrementer;
}

int main() {
  auto incrementByTen = makeIncrementer(10);
  // leads to buggy behavior unlike in Swift!
  // lifetime from runningTotal is not tracked and thus
  // it is no longer properly initialized when it is 
  // accessed after the enclosing method exited.
  std::cout << "First increment call " << incrementByTen() << std::endl;
  std::cout << "Second increment call " <<incrementByTen() << std::endl;
  return 0;
}
