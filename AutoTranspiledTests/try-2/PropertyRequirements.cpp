
#include <string>

struct Person : public FullyNamed {
  std::string fullName;

  Person(std::sting fullName) : fullName{fullName} {}
};
struct Starship : public FullyNamed {
  std::string name;
  std::string prefix;

  Starship(std::string name, std::string prefix) : name{name}, prefix{prefix} {}

  std::string fullName() override {
    return prefix + " " + name;
  }
};

struct FullyNamed {
  virtual std::string fullName() = 0;
};

int main() {
  Person john("John Appleseed");
  Starship ncc1701("Enterprise", "USS");

  return 0;
}