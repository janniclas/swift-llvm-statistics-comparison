
#include <iostream>
#include <string>

using namespace std;

class Food {
    public:
        string name;
        Food(string name) {
            this->name = name;
        }
        Food() {
            this->name = "[Unnamed]";
        }
};

int main() {
    Food burger = Food("Tasty");
    Food random = Food();
    
    return 0;
}