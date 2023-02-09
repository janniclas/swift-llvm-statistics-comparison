

#include <iostream>

struct Animal
{
    public: 
        std::string species;
        static Animal* create(std::string species) {
        if (species.empty())
            {
                return nullptr;
            }
            return new Animal(species);
        }

    private:

    Animal(std::string species)
    {

        this->species = species;
    }
};

int main()
{
    Animal *someCreature = Animal::create("Giraffe");
    if (someCreature)
    {
        std::cout << "An animal was initialized with a species of " << someCreature->species << std::endl;
    }

    Animal *anonymousCreature = Animal::create("");
    if (!anonymousCreature)
    {
        std::cout << "The anonymous creature couldn't be initialized" << std::endl;
    }

    delete someCreature;
    delete anonymousCreature;

    return 0;
}