
#include <iostream>

int implicitReturn(int x);

int main() {
	implicitReturn(42);
}

int implicitReturn(int x) {
	return x + 2;
}