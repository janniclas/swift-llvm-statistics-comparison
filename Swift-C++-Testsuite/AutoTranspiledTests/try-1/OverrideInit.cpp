
#include <iostream>
using namespace std;

class Vehicle
{
   public: 
   int numberOfWheels = 0; 
   string description()
    {
      return  to_string(numberOfWheels) + " wheel(s)";
    }
};


class Bicycle: public Vehicle {
public:
    Bicycle()
    {
        numberOfWheels = 2;
    }
};

class Hoverboard: public Vehicle {
private: 
  string color;
public: 
  Hoverboard(string color)
  {
      this->color = color;
  }
  string description()
  {
      return Vehicle::description() + " in a beautiful " + color;
  }
};


int main()
{
    Bicycle bicycle;
    Hoverboard hoverboard("silver");
    string hovDes = hoverboard.description();
    string biDes = bicycle.description();
    return 0;
}