

#include <iostream>

struct Animal
{
    std::string species;
    Animal(std::string species)
    {
        if (species.empty())
        {
            return;
        }
        this->species = species;
    }
};

int main()
{
    Animal *someCreature = new Animal("Giraffe");
    if (someCreature)
    {
        std::cout << "An animal was initialized with a species of " << someCreature->species << std::endl;
    }

    Animal *anonymousCreature = new Animal("");
    if (!anonymousCreature)
    {
        std::cout << "The anonymous creature couldn't be initialized" << std::endl;
    }

    return 0;
}