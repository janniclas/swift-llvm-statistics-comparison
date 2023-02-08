 
 #include <iostream>
 
 class RandomNumberGenerator
 {
 	public:
 	virtual double random() = 0;
 };
 
 class LinearCongruentialGenerator : public RandomNumberGenerator
 {
 	public:
 	double lastRandom = 42.0;
 	const double m = 139968.0;
 	const double a = 3877.0;
 	const double c = 29573.0;
 	
 	virtual double random()
 	{
 		lastRandom = ((lastRandom * a + c) / m);
 		return lastRandom;
 	}
 
 };
 
 class Dice
 {
 	public:
 	int sides;
 	RandomNumberGenerator *generator;
 	Dice(int sides, RandomNumberGenerator *gen)
 		: sides(sides), generator(gen) { }
 	int roll()
 	{
 		double r = generator->random();
 		return int(r * sides + 1);
 	}
 };
 
 int main()
 {
 	LinearCongruentialGenerator lcg;
 	Dice d6(6, &lcg);
 	for(int i = 0; i < 5; ++i)
 		std::cout << "Random dice roll is " << d6.roll() << std::endl;
 		
 	return 0;
 }