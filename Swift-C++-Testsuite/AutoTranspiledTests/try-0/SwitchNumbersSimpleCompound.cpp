

#include <iostream>

using namespace std;

struct MyMain {
	static int main() {
		int res = switchMe(1);
	}

	static int switchMe(int input) {
		int counter = 0;
		int max = 7;
		switch (input) {
		case 1:
		case 2:
			counter = max;
			break;
		case 0:
			counter = -max;
			break;
		default:
			counter = 42;
			break;
		}
		return counter;
	}
};

int main() {
	MyMain::main();
	return 0;
}