 

#include <iostream> 
#include <string> 

struct Person : FullyNamed 
{ 
    std::string fullName; 
}; 

class Starship : FullyNamed 
{ 
public: 
    std::string prefix; 
    std::string name; 
    Starship(std::string nam, std::string pre = "") 
    { 
        name = nam; 
        if (pre == "") 
            prefix = pre; 
    } 
    std::string fullName() 
    { 
        if (prefix == "") 
            return name; 
        else return prefix + " " + name; 
    } 

}; 

class FullyNamed 
{ 
public: 
    virtual std::string fullName() = 0; 
}; 

int main() 
{ 
    Person john = {"John Appleseed"}; 
    std::string Name = john.fullName; 

    Starship ncc1701 = {"Enterprise", "USS"}; 
    std::string ShipName = ncc1701.fullName(); 
}