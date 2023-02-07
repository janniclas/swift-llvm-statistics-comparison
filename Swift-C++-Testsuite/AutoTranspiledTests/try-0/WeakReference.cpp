
#include <iostream>
#include <string>

class Person 
{
    public: 
        Person(std::string name);
        ~Person(); 
        std::string getName(); 
        void setApartment(Apartment* apartment); 


    private: 
        std::string name; 
        Apartment* apartment;

}; 

Person::Person(std::string name)
{
    this->name = name; 
    std::cout << name << " is being initialized\n"; 
}

Person::~Person(){
    std::cout << name << " is being deinitialized\n"; 

}

std::string Person::getName(){
    return this->name; 
} 

void Person::setApartment(Apartment* apartment){
    this->apartment = apartment; 
}

class Apartment
{
    public: 
        Apartment(std::string unitNumber); 
        ~Apartment(); 
        std::string getUnitNumber(); 
        void setTenant(Person* tenant); 

    private: 
        std::string unitNumber; 
        Person* tenant; 

}; 

Apartment::Apartment(std::string unitNumber)
{
    this->unitNumber = unitNumber;
    std::cout << "Apartment " << unitNumber << " is being initialized\n";
}

Apartment::~Apartment(){
    std::cout << "Apartment" << unitNumber << " is being deinitialized\n"; 
}

std::string Apartment::getUnitNumber(){
    return this->unitNumber; 
} 

void Apartment::setTenant(Person* tenant){
    this->tenant = tenant; 
}

int main(){
    Person* john = new Person("John Appleseed");
    Apartment* unit4A = new Apartment("4A");

    john->setApartment(unit4A); 
    unit4A->setTenant(john); 

    delete john;
    delete unit4A; 


    return 0; 
}