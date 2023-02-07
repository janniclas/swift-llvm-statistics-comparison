
 #include <iostream>
 #include <algorithm>
 #include <vector>

  int main() {
	std::vector<int> numbers = {42, 1, 47, 22, 23, 24};
	sort(numbers.begin(), numbers.end(), std::greater<int>());
	std::vector<int> reversedNumbers = numbers;
}