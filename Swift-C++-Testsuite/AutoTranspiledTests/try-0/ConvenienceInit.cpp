
#include <iostream>

class Food {
public:
    std::string name;
    Food(std::string name) {
        this->name = name;
    }
    Food() {
        this->name = "[Unnamed]";
    }
};

class RecipeIngredient: public Food {
public:
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
    std::cout << "Food: " << random.name << std::endl;
    std::cout << "Recipe Ingredient: " << oneMysteryItem.name << std::endl;
    std::cout << "Quantity of Eggs: " << sixEggs.quantity << std::endl;
    return 0;
}