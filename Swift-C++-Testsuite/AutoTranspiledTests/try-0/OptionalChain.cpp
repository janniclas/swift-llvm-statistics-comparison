
#include <iostream>
using namespace std;

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
    if (john.residence != nullptr && john.residence->numberOfRooms != 0) {
        cout << "John's residence has " << john.residence->numberOfRooms << " room(s)." << endl;
    } else {
        cout << "Unable to retrieve the number of rooms." << endl;
    }
    john.residence = new Residence();
    if (john.residence != nullptr && john.residence->numberOfRooms != 0) {
        cout << "John's residence has " << john.residence->numberOfRooms << " room(s)." << endl;
    } else {
        cout << "Unable to retrieve the number of rooms." << endl;
    }
    return 0;
}