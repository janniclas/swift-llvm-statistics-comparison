
#include <iostream>
#include <map>
using namespace std;

int main() {
	map<int, int> namesOfIntegers;
	namesOfIntegers[5] = 32;
	namesOfIntegers[4] = 42;

	int access = namesOfIntegers.at(4);
 
	return 0;
}