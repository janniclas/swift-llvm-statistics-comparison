
#include <iostream>

struct Resolution {
	int width = 0;
	int height = 0;
};

int main()
{
	Resolution res{ 1920, 1080 };
	Resolution copied = res; // A copy operation
	copied.height = 42;

	std::cout << res.height << std::endl;
	std::cout << copied.height << std::endl;

	return 0;
}