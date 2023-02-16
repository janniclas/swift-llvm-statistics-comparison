
#include <iostream> 
#include <string>
 
class Person {
  private:
    std::string name;
  public:
    Person(std::string name) { 
      this->name = name;
    }
    
    Apartment *apartment;
  
    ~Person() {
      std::cout << name << " is being deinitialized" << std::endl; // deinit prints
    }
};

class Apartment {
  private:
    std::string unit;
  public:
    Apartment(std::string unit) { 
      this->unit = unit;
    }

    Person *tenant;

    ~Apartment() {
      std::cout << "Apartment " << unit << " is being deinitialized" << std::endl; // deinit prints
    }
};

int main() {
    Person *john;
    Apartment *unit4A;

    john = new Person("John Appleseed");
    unit4A = new Apartment("4A");

    john->apartment = unit4A;
    unit4A->tenant = john;
 
    return 0;
}