
 #include <iostream>

using namespace std;

class Customer {
public:
  string name;
  CreditCard* card;
  Customer(string name){
    this->name = name;
  }
  ~Customer(){
    cout << name << " is being deinitialized" << endl;
  }
};

class CreditCard {
public:
  long number;
  Customer customer;
  CreditCard(long number, Customer customer){
    this->number = number;
    this->customer = customer;
  }
  ~CreditCard() {
    cout << "Card #" << number << " is being deinitialized" << endl;
  }
};

int main(){
  Customer *john = new Customer("John Appleseed");
  john->card = new CreditCard(1234567890123456, *john);
  delete john;
  return 0;

}