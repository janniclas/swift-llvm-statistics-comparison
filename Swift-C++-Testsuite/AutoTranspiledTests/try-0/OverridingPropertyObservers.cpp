
#include <iostream>
using namespace std;

class Vehicle{
    public: 
        double currentSpeed =0.0;
        string description(){
            return "traveling at " + to_string(currentSpeed) + " miles per hour";
        }
        void makeNoise(){
            // Do nothing — an arbitrary vehicle doesn't necessarily make a noise
        }
};

class Car : public Vehicle {
    public: 
        int gear = 1;
        string description(){
            return Vehicle::description() + " in gear " + to_string(gear);
        }
};

class AutomaticCar : public Car {
    public: 
        double currentSpeed;
        void setCurrentSpeed(double speed){
            currentSpeed = speed;
            gear = (int) (speed / 10.0) +1;
        }
};

int main(){
    Vehicle* someVehicle = new Vehicle();
    AutomaticCar* automatic = new AutomaticCar();
    automatic->setCurrentSpeed(35.0);
    string des = automatic->description();
    cout << des;
    return 0;
}