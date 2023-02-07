 
 #include <iostream> 
 
struct MyMain {
	static void main() {
		auto incrementByTen = makeIncrementer(10);
		incrementByTen();
		incrementByTen();
	}
};

auto makeIncrementer(int amount) { 
	static int runningTotal = 0; 
	  
	auto incrementer = [&]() { 
		runningTotal += amount; 
		return runningTotal; 
	}; 
	return incrementer;
};

int main() {
	MyMain::main();
	return 0; 
}