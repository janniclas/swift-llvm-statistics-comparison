
#include <iostream>

class Resolution {
	public:
		uint32_t width = 0;
		uint64_t height = 0;
		uint32_t max = 0;

		Resolution() {}

		Resolution(uint32_t w, uint64_t h, uint32_t m) {
			width = w;
			height = h;
			max = m;
		}
};

int main() {
	Resolution res;
	Resolution explicitValues(32, 64, 3232);

	return 0;
}