#include <iostream>
#include <optional>

class Residence {
public:
    Residence() : numberOfRooms(1) {}
    int numberOfRooms;
};

class Person {
public:
    std::optional<Residence> residence;
};

int main() {
    Person john;
    if (john.residence.has_value()) {
        int roomCount = john.residence->numberOfRooms;
        std::cout << "John's residence has " << roomCount << " room(s)." << std::endl;
    } else {
        std::cout << "Unable to retrieve the number of rooms." << std::endl;
    }
    john.residence = Residence();
    if (john.residence.has_value()) {
        int roomCount = john.residence->numberOfRooms;
        std::cout << "John's residence has " << roomCount << " room(s)." << std::endl;
    } else {
        std::cout << "Unable to retrieve the number of rooms." << std::endl;
    }
    return 0;
}
