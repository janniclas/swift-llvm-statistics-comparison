
 #include <iostream>

class Vehicle 
{
  public:
    double currentSpeed = 0.0;
    std::string description() {
        return "traveling at "+std::to_string( currentSpeed )+" miles per hour";
    }
    
    void makeNoise() {
    }
};

class Train : public Vehicle 
{
public:
    void makeNoise() {
        std::cout << "Choo Choo";
    }
};

class Car : public Vehicle 
{
public:
    int gear = 1;
    std::string description() {
        return Vehicle::description() + " in gear "+std::to_string( gear );
    }
};

int main()  
{
    Vehicle someVehicle = Vehicle();
    Train train = Train();
    train.makeNoise();
    Car car = Car();
    car.currentSpeed = 25.0;
    car.gear = 3;
    std::string carDes = car.description();
    return 0;
}