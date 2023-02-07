 
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
 
 int main() {
     Person* john = new Person();
     if (john->residence && john->residence->numberOfRooms) {
         printf("John's residence has %d room(s).\n", john->residence->numberOfRooms);
     } else {
         printf("Unable to retrieve the number of rooms.\n");
     }
     john->residence = new Residence();
     if (john->residence && john->residence->numberOfRooms) {
         printf("John's residence has %d room(s).\n", john->residence->numberOfRooms);
     } else {
         printf("Unable to retrieve the number of rooms.\n");
     }
     return 0;
 }