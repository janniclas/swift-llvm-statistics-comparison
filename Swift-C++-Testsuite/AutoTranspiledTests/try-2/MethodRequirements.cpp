
#include <iostream>

class LinearCongruentialGenerator {
    public: 
        double lastRandom;
        const double m = 139968.0;
        const double a = 3877.0;
        const double c = 29573.0;
        double random() {
            lastRandom = (lastRandom*a + c) % m;
            return lastRandom/m;
        } 
};

int main() {
    LinearCongruentialGenerator generator;
    generator.lastRandom = 42.0;
    std::cout << "Here's a random number: " << generator.random() << std::endl;
    return 0;
}