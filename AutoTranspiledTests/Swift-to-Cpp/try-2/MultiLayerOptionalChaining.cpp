 

#include <iostream> 
#include <string> 
using namespace std; 

class Person 
{ 
public:
  Residence* residence;
};

class Residence
{ 
public:
  int numberOfRooms; 
  Room* rooms = new Room[10]; 
  Address* address; 

  int getNumberOfRooms() 
  { 
    return numberOfRooms;
  } 
  void setNumberOfRooms(int numOfRooms) 
  { 
    this->numberOfRooms = numOfRooms;
  }
  Room getIRoomAtIndex(int index)
  { 
    return rooms[index]; 
  } 
  void setRoomAtIndex(Room room, int index)
  { 
    this->rooms[index] = room;
  }
  void printNumberOfRooms() 
  { 
    cout << "The number of rooms is " << this->numberOfRooms << endl;
  } 
}; 

class Room
{ 
public:
  string name; 
  Room(string name) 
  { 
   this->name = name; 
  }
};

class Address 
{ 
public:
  string buildingName; 
  string buildingNumber;
  string street;
  string buildingIdentifier()
  { 
    if ((buildingNumber != "") && (street != ""))
    { 
      return buildingNumber + " " + street; 
    } 
    else if (buildingName != "") 
    { 
      return buildingName; 
    } 
    else
    {
     return "None"; 
    } 
  }
};

Address createAddress() 
{ 
  cout << "Function was called." << endl;
  Address* someAddress = new Address();
  someAddress->buildingNumber = "29";
  someAddress->street = "Acacia Road";
  return *someAddress;
} 

int main() { 
  Person* john = new Person();
  if (john->residence->numberOfRooms != 0) 
  { 
    cout << "John's residence has " << john->residence->numberOfRooms << " room(s)." << endl; 
  }
  else 
  {
    cout << "Unable to retrieve the number of rooms." << endl; 
  }

  Address someAddress; 
  someAddress.buildingNumber = "29"; 
  someAddress.street = "Acacia Road"; 
  john->residence->address = &someAddress; 
  john->residence->address = &createAddress();

  if (john->residence->printNumberOfRooms() != NULL)
  { 
    cout << "It was possible to print the number of rooms." << endl; 
  } 
  else
  { 
    cout << "It was not possible to print the number of rooms." << endl; 
  }

  if ((john->residence->address = &someAddress) != NULL) 
  { 
    cout << "It was possible to set the address." << endl; 
  } 
  else 
  { 
    cout << "It was not possible to set the address." << endl; 
  }

  if ((john->residence->getIRoomAtIndex(0).name) != "") 
  { 
    cout << "The first room name is " << john->residence->getIRoomAtIndex(0).name << "." << endl; 
  } 
  else 
  { 
    cout << "Unable to retrieve the first room name." << endl; 
  }

  john->residence->setRoomAtIndex(Room("Bathroom"), 0);

  Residence johnsHouse; 
  johnsHouse.setNumberOfRooms(2);
  johnsHouse.setRoomAtIndex(Room("Living Room"), 0);
  johnsHouse.setRoomAtIndex(Room("Kitchen"), 1);
  john->residence = &johnsHouse;

  if ((john->residence->getIRoomAtIndex(0).name) != "")
  { 
    cout << "The first room name is " << john->residence->getIRoomAtIndex(0).name << "." << endl; 
  } 
  else
  {
    cout << "Unable to retrieve the first room name." << endl;
  }

  Address johnsAddress; 
  johnsAddress.buildingName = "The Larches";
  johnsAddress.street = "Laurel Street";
  john->residence->address = &johnsAddress; 

  if ((john->residence->address->street) != "") 
  { 
    cout << "John's street name is " << john->residence->address->street << "." << endl; 
  } 
  else 
  { 
    cout << "Unable to retrieve the address." << endl; 
  }

  string buildingIdentifier = john->residence->address->buildingIdentifier(); 
  if (buildingIdentifier.find("The") != string::npos) 
  { 
    cout << "John's building identifier begins with \"The\"." << endl;
  } 
  else 
  { 
    cout << "John's building identifier doesn't begin with \"The\"." << endl; 
  } 

  return 0; 
}