
#include <iostream>
using namespace std;

// Class Vehicle
class Vehicle {
 public:
  double currentSpeed = 0.0;
  string description() {
    return "traveling at " + std::to_string(currentSpeed) +
           " miles per hour";
  }
  void makeNoise() {
    // do nothing - an arbitrary vehicle doesn't necessarily make a noise
  };
};

// Subclass Train (Override makeNoise())
class Train : public Vehicle {
  public: 
  void makeNoise() { std::cout << "Choo Choo" << '\n'; }
};

// Subclass Car (Override getter from property, and add a setter)
class Car : public Vehicle {
 private:
  int gear = 1;

 public:
  void setGear(int val) { gear = val; }
  int getGear() { return gear; }
  string description() {
    return Vehicle::description() + " in gear " + std::to_string(gear);
  }
};

// Main Method
int main() {
  Vehicle someVehicle;
  Train train;
  train.makeNoise();
  Car car;
  car.currentSpeed = 25.0;
  car.setGear(3);
  string carDes = car.description();
  return 0;
}