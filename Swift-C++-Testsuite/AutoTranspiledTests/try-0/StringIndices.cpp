
 #include <iostream>
#include <string>

int main() {

  std::string greeting = "Guten Tag!";
  std::cout << greeting[0] << std::endl; // G
  std::cout << greeting[greeting.length() -1] << std::endl; // !
  std::cout << greeting[1] << std::endl; // u

  std::string::iterator index = greeting.begin() + 7;
  std::cout << *index << std::endl; // a

  for (auto index = greeting.begin(); index != greeting.end(); index++){
      char curr = *index;
      std::cout << curr << std::endl;
  }

  greeting.insert(greeting.length(), "!");
  greeting.erase(greeting.length() - 2, greeting.length());

  return 0;
}