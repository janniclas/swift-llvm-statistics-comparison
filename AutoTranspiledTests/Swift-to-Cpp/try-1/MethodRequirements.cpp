
 #include <iostream>
 using namespace std;
 
class LinearCongruentialGenerator : public RandomNumberGenerator {
  public:
  
  double lastRandom = 42.0;
  const double m = 139968.0;
  const double a = 3877.0;
  const double c = 29573.0;
  
  double random() {
    lastRandom = ((lastRandom * a + c) / m);
    return lastRandom % m;
  }
};
 
class MyMain {
 
 public:
  static void main() {
    LinearCongruentialGenerator generator;
    cout << "Here's a random number: " << generator.random() << endl;
  }
};

int main() {
  MyMain main;
  main.main();
 
  return 0;
}