
 
#include <iostream>

using namespace std;

// Prototype for addTwoInts 
int addTwoInts(int a, int b);

int main() {
	int (*mathFunction)(int, int); // Declaration of a function pointer
	mathFunction = &addTwoInts;
	int result = mathFunction(42, 44);
	
	return 0;
}

int addTwoInts(int a, int b) {
	return a + b;
}