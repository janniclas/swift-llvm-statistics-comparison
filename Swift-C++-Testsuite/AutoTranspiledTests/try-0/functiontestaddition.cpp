
#include <ctime>
#include <cstdlib>
#include <iostream>
 
int magical(int z) {
	const int a = 78092278;
	const int b = 45124;
	int x = a + b;
	return x + z;
}
 
int main() {
	int rand = (rand() % 100) + 1;
	int myResult = -1;
	if (rand < 40) {
		myResult = magical(rand);
		//78149714
	}
	else {
		myResult = magical(12411);
		//78149713
	}
	return 0;
}