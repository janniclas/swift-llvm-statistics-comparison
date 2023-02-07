
#include <iostream>

class MyMain
{
public:
	static void main()
	{
		LinearCongruentialGenerator generator;
		std::cout << "Here's a random number: " << generator.random() << std::endl;
	}
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
		lastRandom = ((lastRandom * a + c)
			.truncatingRemainder(dividingBy: m));
		return lastRandom / m;
	}
};

class RandomNumberGenerator
{
public:
	virtual double random() = 0;
};

int main()
{
	MyMain::main();
	return 0;
}