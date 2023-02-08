#include <iostream>
#include <string>

class FullyNamed {
  public:
    virtual std::string getFullName() = 0;
};

class Person : public FullyNamed {
    public: 
    Person(std::string name) {
      fullName = name;
    }
    std::string getFullName() {
      return fullName;
    }
    std::string fullName;
};

class Starship : public FullyNamed {
  private:
    std::string name;
    std::string prefix;
  public:
    Starship(std::string name, std::string prefix = "") : name(name), prefix(prefix) {}
    std::string getFullName() {
        return (prefix.empty() ? "" : prefix + " ") + name;
    }
};


int main() {
    Person john = {"John Appleseed"};
    Starship ncc1701 = {"Enterprise", "USS"};
    return 0;
}
