
int takeMathFunction(int(*mathFunction)(int, int), int a, int b) {
   int exec = mathFunction(a, b);
   return exec;
}

int addTwoInts(int a, int b) {
	return a + b;
}

int main() {
	int(*mathFunction)(int, int);
	mathFunction = addTwoInts;
	int result = takeMathFunction(mathFunction, 42, 44);
	return 0;
	
}