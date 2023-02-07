
 #include <iostream>
 #include <algorithm>
 #include <vector>
 
 int main() {
     std::vector<int> numbers = {42, 1, 47, 22, 23, 24};
     std::sort(numbers.begin(), numbers.end(), std::greater<int>());
     return 0;
 }