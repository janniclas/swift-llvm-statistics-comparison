
#include <iostream>

struct Main {
	static void main() {
		double oneInch = 25.4 * mm;
		std::cout << "One inch is " << oneInch << " meters" << std::endl;
		
		double threeFeet = 3.0 * ft;
		std::cout << "Three feet is " << threeFeet << " meters" << std::endl;
	}
};

double km(double x) {
	return x * 1000;
}

double m(double x) {
	return x;
}

double cm(double x) {
	return x / 100;
}

double mm(double x) {
	return x / 1000;
}

double ft(double x) {
	return x / 3.28084;
}

int main() {
	Main::main();
	return 0;
}