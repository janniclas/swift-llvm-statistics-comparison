
#include <iostream>

class Person {
    public:
        Residence* residence;
};

class Residence {
    public:
        int numberOfRooms = 1;
};

int main()
{
    Person john;
    if (john.residence && john.residence->numberOfRooms) {
        std::cout << "John's residence has " << john.residence->numberOfRooms << " room(s)." << std::endl;
    } else {
        std::cout << "Unable to retrieve the number of rooms." << std::endl;
    }

    john.residence = new Residence();
    if (john.residence && john.residence->numberOfRooms) {
        std::cout << "John's residence has " << john.residence->numberOfRooms << " room(s)." << std::endl;
    } else {
        std::cout << "Unable to retrieve the number of rooms." << std::endl;
    }
    
    return 0;
}