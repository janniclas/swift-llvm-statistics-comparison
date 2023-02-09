
#include <iostream>

using namespace std;

class Vehicle {

public:
  double currentSpeed = 0.0;
  string getDescription() {
    return "traveling at " + to_string(currentSpeed) + " miles per hour";
  };
  virtual void makeNoise() {
    // do nothing - an arbitrary vehicle doesn't necessarily make a noise
  }
};

class Bicycle: public Vehicle {
public:
  bool hasBasket = false;
};

class Tandem: public Bicycle {
public:
  int currentNumberOfPassengers = 0;
};

int main() {
  Vehicle *someVehicle = new Vehicle();
  Bicycle *bicycle = new Bicycle();
  bicycle->hasBasket = true;
  Tandem *tandem = new Tandem();
  tandem->hasBasket = true;
  tandem->currentNumberOfPassengers = 2;
  tandem->currentSpeed = 22.0;
  string des = tandem->getDescription();

  delete someVehicle;
  delete bicycle;
  delete tandem;

  return 0;
}