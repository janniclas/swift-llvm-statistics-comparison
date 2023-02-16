 
#include <iostream>

int runningTotal = 0;

int makeIncrementer(int amount) {
    runningTotal += amount;
    return runningTotal;
};

int main() {
    int incrementByTen = makeIncrementer(10);
    std::cout << incrementByTen << "\n";
    std::cout << makeIncrementer(10) << "\n";
    return 0;
}