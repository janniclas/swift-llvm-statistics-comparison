#include <iostream>
#include <vector>
#include <string>
#include <optional>

using namespace  std;

class Address {
public:
    std::optional<std::string> buildingName;
    std::optional<std::string> buildingNumber;
    std::optional<std::string> street;
    std::optional<std::string> buildingIdentifier() {
        if (buildingNumber && street) {
            return *buildingNumber + " " + *street;
        }
        else if (buildingName) {
            return *buildingName;
        }
        else {
            return std::nullopt;
        }
    }
};

class Room {
public:
    std::string name;
    Room(std::string name) : name(name) {}
};

class Residence {
public:
    std::vector<Room> rooms;
    int numberOfRooms() {
        return rooms.size();
    }
    Room operator[](int i) {
        return rooms[i];
    }

    void printNumberOfRooms() {
        std::cout << "The number of rooms is " << numberOfRooms() << std::endl;
    }
    std::optional<Address> address;
};

Address createAddress() {
    std::cout << "Function was called." << std::endl;

    Address someAddress;
    someAddress.buildingNumber = "29";
    someAddress.street = "Acacia Road";

    return someAddress;
}

class Person {
public:
    std::optional<Residence> residence;
};

int main() {
  Person john;
  if (john.residence) {
    cout << "John's residence has " << john.residence->numberOfRooms() << " room(s)." << endl;
  } else {
    cout << "Unable to retrieve the number of rooms." << endl;
  }

  Address someAddress;
  someAddress.buildingNumber = "29";
  someAddress.street = "Acacia Road";
  john.residence->address = someAddress;
  john.residence->address = createAddress();

  if (john.residence ) {
    john.residence->printNumberOfRooms();
    cout << "It was possible to print the number of rooms." << endl;
  } else {
    cout << "It was possible to print the number of rooms." << endl;
  }

  if (john.residence) {
    john.residence->address = someAddress;
    cout << "It was possible to set the address." << endl;
  } else {
    cout << "It was not possible to set the address." << endl;
  }

  if (john.residence && john.residence->rooms.size() > 0) {
    cout << "The first room name is " << john.residence->rooms[0].name << endl;
  } else {
    cout << "Unable to retrieve the first room name." << endl;
  }

    if( john.residence) {
        john.residence->rooms[0] = Room("Bathroom");
    }

  Residence johnsHouse;
  johnsHouse.rooms.push_back(Room{"Living Room"});
  johnsHouse.rooms.push_back(Room{"Kitchen"});
  john.residence = johnsHouse;

  if (john.residence && john.residence->rooms.size() > 0) {
    cout << "The first room name is " << john.residence->rooms[0].name << endl;
  } else {
    cout << "Unable to retrieve the first room name." << endl;
  }

    Address johnsAddress;
  johnsAddress.buildingName = "The Larches";
  johnsAddress.street = "Laurel Street";
  john.residence->address = johnsAddress;
  if (john.residence && john.residence->address && john.residence->address->street) {
    cout << "John's street name is " << john.residence->address->street.value() << endl;
  } else {
    cout << "Unable to retrieve the address." << endl;
  }

    if (john.residence && john.residence->address && john.residence->address->buildingIdentifier()) {
        cout << "John's building identifier is " << john.residence->address->buildingIdentifier().value() << endl;
    }
    if (john.residence && john.residence->address && john.residence->address->buildingIdentifier()) {
        bool beginsWithThe = john.residence->address->buildingIdentifier().value().substr(0, john.residence->address->buildingIdentifier().value().length()) == "The";
        if (beginsWithThe) {
            cout << "John's building identifier begins with \"The\"." << endl;
        } else {
            cout << "John's building identifier doesn't begin with \"The\"." << endl;
        }
    }

}