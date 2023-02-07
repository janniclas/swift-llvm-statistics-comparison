
#include <iostream>
#include <algorithm>
#include <vector>

int main() {
   
    std::vector<int> numbers = {42, 1, 47, 22, 23, 24};
 
    std::sort(numbers.begin(), numbers.end(), [](int s1, int s2) { return s1 > s2;});

    return 0;
}