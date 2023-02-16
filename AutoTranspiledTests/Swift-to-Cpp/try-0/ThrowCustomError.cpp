
#include <iostream>

enum VendingMachineError {
  InvalidSelection,
  InsufficientFunds,
  OutOfStock
};

int main() {
  try {
    throw VendingMachineError::InsufficientFunds;
  } catch (const VendingMachineError& e) {
    std::cout << e;
  }
  return 0;
}