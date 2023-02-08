
#include <iostream>
#include <math.h>


class RandomNumberGenerator
{
public:
	virtual double random() = 0;
};

class LinearCongruentialGenerator : public RandomNumberGenerator
{
private:
	double lastRandom = 42.0;
	const double m = 139968.0;
	const double a = 3877.0;
	const double c = 29573.0;

public:
	double random() {
		lastRandom = fmod((lastRandom * a + c),m);
		return lastRandom / m;
	}
};


int main()
{
		LinearCongruentialGenerator generator;
		std::cout << "Here's a random number: " << generator.random() << std::endl;
	
}