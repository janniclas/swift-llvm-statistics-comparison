
#include <string>

struct Resolution {
    int width = 0;
    int height = 0;
};

struct VideoMode {
    Resolution resolution = Resolution();
    bool interlaced = false;
    double frameRate = 0.0;
    std::string name = "";
};

int main(){
	VideoMode vm;
	Resolution res;
	double fr = vm.frameRate;
	int px = res.height * res.width;

	return 0;
}