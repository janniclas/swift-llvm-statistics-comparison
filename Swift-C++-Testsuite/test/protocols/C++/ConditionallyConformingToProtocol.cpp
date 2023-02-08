
 #include <iostream>
 #include <string>
 #include <vector>
 #include <math.h>
 
 class RandomNumberGenerator {
	public:
		virtual double random() = 0;
 };

 class Dice {
	 int sides;
	 RandomNumberGenerator *generator;
 public:
	 Dice(int sides, RandomNumberGenerator *generator) : sides(sides), generator(generator) {
 
	 }
	 int roll() {
		 return int(generator->random() * sides) + 1;
	 }
	 virtual std::string textualDescription() {
		 return "A " + std::to_string(sides) + "-sided dice";
	 }
 };
 
 class LinearCongruentialGenerator : public RandomNumberGenerator {
	 double lastRandom = 42.0;
	 double m = 139968.0;
	 double a = 3877.0;
	 double c = 29573.0;
 public:
	 double random() {
		 lastRandom = fmod((lastRandom * a + c), m);
		 return lastRandom / m;
	 }
 };
 
 template<typename T>
 class TextRepresentable {
 public:
	 virtual std::string textualDescription() = 0;
 };
 
 template<typename T>
 class Vector : public TextRepresentable<T> {
	 std::vector<T> myDice;
 public:
	 Vector(std::vector<T> myDice) : myDice(myDice) {
 
	 }
	 std::string textualDescription() {
		 std::string res = "[";
		 for (int i = 0; i < myDice.size(); i++) {
			 res += myDice[i]->textualDescription();
			 if (i != myDice.size() - 1) {
				 res += ", ";
			 }
		 }
		 res += "]";
		 return res;
	 }
 };
 
 int main() {
	 LinearCongruentialGenerator *src = new LinearCongruentialGenerator();
	 Dice *d12 = new Dice(12, src);
	 Dice *d6 = new Dice(6, src);
	 std::vector<Dice*> myDice = { d6, d12 };
	 Vector<Dice*> vec(myDice);
	 std::cout << vec.textualDescription();
	 delete src;
	 delete d12;
	 delete d6;
 }