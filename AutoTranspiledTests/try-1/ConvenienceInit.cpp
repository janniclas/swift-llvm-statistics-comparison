
/*
	@main
*/
 
#include <iostream>
using std::cout;
using std::endl;
 
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

class RecipeIngredient : public Food {
  public:
    int quantity;
    RecipeIngredient(string name, int quantity) : Food(name) {
      this->quantity = quantity;
    }
    RecipeIngredient(string name) : Food(name) {
      this->quantity = 1;
    }
};

int main() {
  	Food burger("Tasty");
    Food random;
    RecipeIngredient oneMysteryItem;
    RecipeIngredient oneBacon("Bacon");
    RecipeIngredient sixEggs("Eggs", 6);
    return 0;
}