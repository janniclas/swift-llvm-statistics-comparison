
 #include <iostream>
 #include <string>
 #include <array>

 int main() {
	std::array<std::any,0> emptyArrayNoType;
	std::array<int,0> emptyArray;
	
	std::array<int, 5> numberArray = {1, 2, 3, 4, 5}; 
	std::array<std::string,2> stringArray = {"Test", "Input"};
	
	 return 0;
 }