
struct Animal {
    std::string species;
    Animal(std::string species_) {
        if (species_.empty()) { return; }
        species = species_;
    }
};

int main() {
    Animal* someCreature = new Animal("Giraffe");
    // someCreature is of type Animal*, not Animal
 
    if (someCreature != nullptr) {
        std::cout << "An animal was initialized with a species of " << someCreature->species << std::endl;
    }

    Animal* anonymousCreature = new Animal("");
    // anonymousCreature is of type Animal*, not Animal

    if (anonymousCreature == nullptr) {
        std::cout << "The anonymous creature couldn't be initialized";
    }
 
    return 0;
}