
#include <iostream>
#include <string>

class Person {
	public: 
		Residence *residence;
};

class Residence {
	public:
		Room *rooms;
		int numberOfRooms;
		Room* get(int i);
		void set(int i, Room room);
		void printNumberOfRooms();
		Address *address;
};

class Room {
	public:
	   std::string name;
	   Room(std::string name0){
		   this->name = name0;
	   }
};

class Address {
public:
	std::string buildingName;
	std::string buildingNumber;
	std::string street;
	std::string buildingIdentifier();
};

int main(){
	Person john = Person();
	if(john.residence->numberOfRooms != NULL){
		std::cout << "John's residence has " << john.residence->numberOfRooms << " room(s)." << std::endl;
	}
	else {
		std::cout << "Unable to retrieve the number of rooms." << std::endl;
	}
	Address someAddress = Address();
	someAddress.buildingNumber = "29";
	someAddress.street = "Acacia Road";
	john.residence->address = someAddress;
	john.residence->address = createAddress();
	if(john.residence->printNumberOfRooms() != NULL){
		std::cout << "It was possible to print the number of rooms." <<std::endl;
	}
	else {
		std::cout << "It was not possible to print the number of rooms." << std::endl;
	}
	if((john.residence->address = someAddress) != NULL){
		std::cout << "It was possible to set the address." << std::endl;
	}
	else {
		std::cout << "It was not possible to set the address." << std::endl;
	}
	if(john.residence->get(0)->name != NULL){
		std::cout << "The first room name is " << john.residence->get(0)->name << "." << std::endl;
	}
	else {
		std::cout << "Unable to retrieve the first room name." << std::endl;
	}
	john.residence->set(0, Room("Bathroom"));

	Residence johnsHouse = Residence();
	johnsHouse.rooms[0] = Room("Living Room");
	johnsHouse.rooms[1] = Room("Kitchen");
	john.residence = &johnsHouse;

	if(john.residence->get(0)->name != NULL){
		std::cout << "The first room name is " << john.residence->get(0)->name << "." << std::endl;
	}
	else {
		std::cout << "Unable to retrieve the first room name." << std::endl;
	}

	Address johnsAddress = Address();
	johnsAddress.buildingName = "The Larches";
	johnsAddress.street = "Laurel Street";
	john.residence->address = &johnsAddress;

	if(john.residence->address->street != NULL){
		std::cout << "John's street name is " << john.residence->address->street << "." << std::endl;
	}
	else {
		std::cout << "Unable to retrieve the address." << std::endl;
	}

	if(john.residence->address->buildingIdentifier() != NULL){
		std::cout << "John's building identifier is " << john.residence->address->buildingIdentifier() << "." << std::endl;
		if(john.residence->address->buildingIdentifier().substr(0,3) == "The"){
			std::cout << "John's building identifier begins with \"The\"." << std::endl;
		}
		else{
			std::cout << "John's building identifier doesn't begin with \"The\".";
		}
	}
	return 0;
}

Room* Residence::get(int i){
	return &rooms[i];
}

void Residence::set(int i, Room room){
	rooms[i] = room;
}

void Residence:: printNumberOfRooms(){
	std::cout << "The number of rooms is " << numberOfRooms << std::endl;
}

std::string Address::buildingIdentifier(){
   if(buildingNumber != "" && street != ""){
	   return buildingNumber + " " + street;
   }
   else if(buildingName != ""){
	   return buildingName;
   }
   else {
	   return "";
   }
}

Address createAddress(){
	std::cout << "Function was called." << std::endl;
	Address someAddress = Address();
	someAddress.buildingNumber = "29";
	someAddress.street = "Acacia Road";
	return someAddress;
}