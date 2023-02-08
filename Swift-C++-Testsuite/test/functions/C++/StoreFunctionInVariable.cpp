
int addTwoInts(int a, int b) {
	return a + b;
}

int main() {
	int (*mathFunction)(int, int); // Declaration of a function pointer
	mathFunction = &addTwoInts;
	int result = mathFunction(42, 44);
	
	return 0;
}

