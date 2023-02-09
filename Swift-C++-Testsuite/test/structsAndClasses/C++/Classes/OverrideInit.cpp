#include <string>



class Vehicle {
public:
	int numberOfWheels = 0;
	std::string description() {
		return std::to_string(numberOfWheels) + " wheel(s)";
	}
};

class Bicycle : public Vehicle {
public:
	Bicycle(): Vehicle() {
		numberOfWheels = 2;
	}
};

class Hoverboard : public Vehicle {
private:
	std::string color;
public:
	Hoverboard(std::string color) : color(color) {};
	std::string description() {
		return Vehicle::description() + " in a beautiful " + color;
	}
};

int main()
{
	Bicycle bicycle;
	Hoverboard hoverboard("silver");
	std::string hovDes = hoverboard.description();
	std::string biDes = bicycle.description();
	return 0;
}