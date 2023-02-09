
#include <iostream>

class Food {
public:
    std::string name;
    Food(std::string name) {
        this->name = name;
    }
    Food(): name("[Unnamed]") {
    }
};

class RecipeIngredient: public Food {
public:
using Food::Food;
    int quantity;
    RecipeIngredient( std::string name, int quantity) {
        this->name = name;
        this->quantity = quantity;
    }
    RecipeIngredient( std::string name) {
        this->name = name;
        this->quantity = 1;
    }
};

int main(){
    Food burger = Food("Tasty");
    Food random = Food();
    RecipeIngredient oneMysteryItem = RecipeIngredient();
    RecipeIngredient oneBacon = RecipeIngredient("Bacon");
    RecipeIngredient sixEggs = RecipeIngredient("Eggs", 6);
    
    return 0;
}