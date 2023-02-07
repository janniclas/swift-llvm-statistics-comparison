
#include <iostream>
#include <string>
#include <vector>
using namespace std;
class Person {
public:
    Residence* residence = nullptr;
};
class Residence {
public:
    vector<Room> rooms;
    int numberOfRooms(){
        return rooms.size();
    }
    Room& operator[](const int i){
        return rooms[i];
    }
    void printNumberOfRooms(){
        cout << "The number of rooms is " << numberOfRooms() << endl;
    }
    Address* address = nullptr;
};
class Room {
public:
    string name;
    Room(string name_){ name = name_; };
};
class Address {
public:
    string buildingName;
    string buildingNumber;
    string street;
    string buildingIdentifier(){
        string ret = "";
        if(buildingNumber !=  "" && street != ""){
            ret = buildingNumber + " " + street;
        }else if(buildingName != ""){
            ret = buildingName;
        }
        return ret;
    }
};
int main(){
    Person john;
    if(john.residence != nullptr && john.residence->numberOfRooms() != 0){
        cout << "John's residence has " << john.residence->numberOfRooms() << " room(s)." << endl;
    }else{
        cout << "Unable to retrieve the number of rooms." << endl;
    }
    Address someAddress;
    someAddress.buildingNumber = "29";
    someAddress.street = "Acacia Road";
    if(john.residence != nullptr)
    {
        john.residence->address = &someAddress;
        john.residence->address = createAddress();
    }
    if(john.residence != nullptr && john.residence->printNumberOfRooms() != 0){
        cout << "It was possible to print the number of rooms." << endl;
    }else{
        cout << "It was not possible to print the number of rooms." << endl;
    }
    if(john.residence != nullptr){
        john.residence->address = &someAddress;
        cout << "It was possible to set the address." << endl;
    }else{
        cout << "It was not possible to set the address." << endl;
    }
    if(john.residence != nullptr && john.residence->numberOfRooms() != 0){
        cout << "The first room name is " << john.residence->rooms[0].name << "." << endl;
    }else{
        cout << "Unable to retrieve the first room name." << endl;
    }
    john.residence->rooms[0] = Room("Bathroom");
    Residence johnsHouse;
    johnsHouse.rooms.emplace_back(Room("Living Room"));
    johnsHouse.rooms.emplace_back(Room("Kitchen"));
    john.residence = &johnsHouse;
    if(john.residence != nullptr && john.residence->numberOfRooms() != 0){
        cout << "The first room name is " << john.residence->rooms[0].name << "." << endl;
    }else{
        cout << "Unable to retrieve the first room name." << endl;
    }
    Address johnsAddress;
    johnsAddress.buildingName = "The Larches" 
    johnsAddress.street = "Laurel Street";
    john.residence->address = &johnsAddress;
    if(john.residence != nullptr && john.residence->address!=nullptr){
        cout << "John's street name is " << john.residence->address->street << "." << endl;
    }else{
        cout << "Unable to retrieve the address." << endl;
    }
    if(john.residence != nullptr && john.residence->numberOfRooms() != 0 && john.residence->address != nullptr && john.residence->address->buildingIdentifier() != ""){
        cout << "John's building identifier is " << john.residence->address->buildingIdentifier() << "." << endl;
    }
    if(john.residence != nullptr && john.residence->numberOfRooms() != 0 && john.residence->address != nullptr && john.residence->address->buildingIdentifier() != ""){
        if(john.residence->address->buildingName.substr(0,3) == "The"){
            cout << "John's building identifier begins with \"The\"" << endl;
        }else{
            cout << "John's building identifier doesn't begin with \"The\"." << endl;
        }
    }
    return 0;
}

Address*  createAddress(){
    cout << "Function was called." << endl;
    Address* someAddress = new Address();
    someAddress->buildingNumber = "29";
    someAddress->street = "Acacia Road";

    return someAddress;
}