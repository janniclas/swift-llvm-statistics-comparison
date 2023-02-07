
#include <string>

class Food {
public:
    std::string name;
    Food(std::string name) : name(name) {};
    Food() : name("[Unnamed]") {};
};

class RecipeIngredient : public Food {
public:
    int quantity;
    RecipeIngredient(std::string name, int quantity) : Food(name), quantity(quantity) {};
    RecipeIngredient(std::string name) : Food(name), quantity(1) {};
};

int main(){
    Food burger = Food("Tasty");
    Food random = Food();
    RecipeIngredient oneMysteryItem = RecipeIngredient();
    RecipeIngredient oneBacon = RecipeIngredient("Bacon");
    RecipeIngredient sixEggs = RecipeIngredient("Eggs", 6);
    
    return 0;
}
    // End