
#include <iostream>
#include <string>

using namespace std;

class Person {
    private:
        string name;
    public:
        Person(string name_in) {
            name = name_in;
        }
        void set_apartment(Apartment *ap) {
            apartment = ap;
        }
        ~Person() {
            cout << name << " is being deinitialized" << endl;
        }
    private:
        Apartment *apartment; 
};

class Apartment {
    private:
        string unit;
    public:
        Apartment(string unit_in) {
            unit = unit_in;
        }
        void set_tenant(Person *p) {
            tenant = p;
        }
        ~Apartment() {
            cout << "Apartment " << unit << " is being deinitialized" << endl;
        }
    private:
        Person *tenant;
};

int main() {
    Person *john = new Person("John Appleseed");
    Apartment *unit4A = new Apartment("4A");
    john->set_apartment(unit4A);
    unit4A->set_tenant(john);
    delete john;
    delete unit4A;
    return 0;
}