
#include <vector>

int main() {
  std::vector<int> customersInLine = {1, 2, 3, 4, 5, 6, 42};

  struct Serve {
    static void serve(std::vector<int> customersInLine) {
      int customerProvider = customersInLine[0];
      customersInLine.erase(customersInLine.begin());
    }
  };

  Serve::serve(customersInLine);

  return 0;
}