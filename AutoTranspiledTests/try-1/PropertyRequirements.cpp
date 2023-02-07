
#include<iostream>
#include<string>

// Struct Person
struct Person : FullyNamed
{
    std::string fullName;
    Person(std::string name) : fullName(name) {}
};

// Class Starship
class Starship : public FullyNamed
{
    public:
    std::string prefix;
    std::string name;

    Starship(std::string name, std::string prefix = ""){
        this->prefix = prefix;
        this->name = name;
    }

    std::string fullName(){
        if(prefix == "") return name;
        else return (prefix + " " + name);
    }
    
};

// Interface FullyNamed
class FullyNamed{
    public:
    virtual std::string fullName() = 0;
};

// main function
int main(){
    Person john("John Appleseed");
    Starship ncc1701("Enterprise", "USS");
    return 0;
}