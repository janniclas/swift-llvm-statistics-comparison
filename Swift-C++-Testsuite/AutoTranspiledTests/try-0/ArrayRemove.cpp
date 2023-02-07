
#include <iostream>
#include <vector>

int main() {
    std::vector<int> a = {2, 42, 44};
    a.erase(a.begin() + 1);
    return 0;
}