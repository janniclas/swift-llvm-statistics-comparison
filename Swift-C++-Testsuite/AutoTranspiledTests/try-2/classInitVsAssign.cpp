 

#include <iostream>

class SomeClass {
public:
	std::string text;
	SomeClass(std::string text) {
		this->text = text;
	}

	void ask() {
		std::cout << text << std::endl;
	}
};

void testDI(bool cond) {
	SomeClass *c;
	if (cond) {
		c = new SomeClass("12345");
	}

	c = new SomeClass("6789");  // init or assign?

	c->ask();

}

int main() {
	testDI((rand() % 100) > 50);
	return 0;
}