
//main
#include <iostream>
#include <string>
using namespace std;

class Dice {

public: 
	int sides;
	class RandomNumberGenerator* generator;
	
	Dice (int sides, RandomNumberGenerator* generator){
		this->sides = sides;
		this->generator = generator;
	}
	
	int roll(){
		return int(generator->random() * sides) + 1;
	}
	
};

class RandomNumberGenerator {
public: 
	virtual double random() = 0;
};

class LinearCongruentialGenerator : public RandomNumberGenerator {
	
public:
	double lastRandom = 42.0;
	double m = 139968.0;
	double a = 3877.0;
	double c = 29573.0;
	double random(){
		lastRandom = (lastRandom * a + c) % m;
		return lastRandom / m;
	}
	
};

class TextRepresentable {
public:
	virtual string textualDescription() = 0;
};


class TextRepresentableArray : public TextRepresentable {
	
	TextRepresentable** array;
	int length;
	
public: 
	TextRepresentableArray(TextRepresentable** array, int length){
		this ->array = array;
		this->length = length;
	}
	
	string textualDescription(){
		string description = "[";
		for (int i = 0; i < length-1; i++){
			description += array[i]->textualDescription() + ", ";
		}
		description += array[length-1]->textualDescription() + "]";
		return description;
	}
	
};


class DiceTextDescrption : public TextRepresentable {
	
	Dice* dice;
	
public:
	
	DiceTextDescrption(Dice* dice){
		this->dice = dice;
	}
	
	string textualDescription(){
		return "A " + to_string(dice->sides) + "-sided dice";
	}
	
};



int main(){
	Dice* d12 = new Dice(12, new LinearCongruentialGenerator());
	Dice* d6 = new Dice(6, new LinearCongruentialGenerator());
	
	TextRepresentable* myDice[2] = {new DiceTextDescrption(d12), new DiceTextDescrption(d6)};
	
	TextRepresentableArray myDiceArray(myDice,2);
	
	cout << myDiceArray.textualDescription() << endl;
	
	return 0;
}