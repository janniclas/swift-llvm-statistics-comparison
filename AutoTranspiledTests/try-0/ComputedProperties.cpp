 
 #include <iostream> 

struct Mymain {
	static void Main() {
		double oneInch = 25.4 * mm;
		std::cout << "One inch is " << oneInch << " meters" << std::endl; 
		double threeFeet = 3 * ft;
		std::cout << "Three feet is " << threeFeet << " meters" << std::endl; 
	}
};

double km (double self) { return self * 1000.0 };
double m (double self) { return self };
double cm (double self) { return self / 100.0 };
double mm (double self) { return self / 1000.0 };
double ft (double self) { return self / 3.28084 };

int main() {
	Mymain::Main(); 
	return 0; 
}