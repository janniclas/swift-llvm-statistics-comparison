
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Dice {
private:
  int sides;
  RandomNumberGenerator* generator;

public:
  Dice(int sides, RandomNumberGenerator* generator) {
    this->sides = sides;
    this->generator = generator;
  }
  int roll() {
    return (int) (generator->random() * sides) + 1;
  }
};

class TextRepresentable {
public:
  virtual string textualDescription() = 0;
};

class Array : public TextRepresentable {
private:
  vector<TextRepresentable*> elements;

public:
  Array(vector<TextRepresentable*> elements) {
    this->elements = elements;
  }

  string textualDescription() {
    string text = "[";
    for (int i = 0; i < elements.size() - 1; i++) {
      text += elements[i]->textualDescription() + ", ";
    }
    text += elements[elements.size() - 1]->textualDescription() + "]";
    return text;
  }
};

class Dice : public TextRepresentable {
private:
  int sides;

public:
  Dice(int sides) {
    this->sides = sides;
  }

  string textualDescription() {
    return "A " + to_string(sides) + "-sided dice";
  }
};

class LinearCongruentialGenerator : RandomNumberGenerator {
private:
  double last_random = 42.0;
  const double M = 139968.0;
  const double A = 3877.0;
  const double C = 29573.0;

public:
  double random() {
    last_random = fmod(last_random * A + C, M);
    return last_random / M;
  }
};

RandomNumberGenerator* generator = new LinearCongruentialGenerator();
Dice d12(12, generator);
Dice d6(6, generator);
vector<TextRepresentable*> myDice = {&d6, &d12};
Array array(myDice);
cout << array.textualDescription() << endl;