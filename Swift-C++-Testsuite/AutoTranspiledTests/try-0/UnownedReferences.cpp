
#include <iostream>
#include <string>

class Customer {
public:
  Customer(std::string name) : name(name) {}
  
  ~Customer() { 
    std::cout << name << " is being deinitialized\n";
  }
 
  std::string name;
  CreditCard* card = nullptr;
};

class CreditCard {
public:
  CreditCard(unsigned long long number, Customer& customer)
      : number(number), customer(customer){};

  ~CreditCard() {
    std::cout << "Card #" << number << " is being deinitialized\n";
  }
 
  unsigned long long number;
  Customer& customer;
};

int main() {
  Customer* john = new Customer("John Appleseed");
  john->card = new CreditCard(1234567890123456, *john);

  delete john;

  return 0;
}