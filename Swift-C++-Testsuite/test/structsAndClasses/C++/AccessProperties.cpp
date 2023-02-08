
#include <iostream>
#include <optional>

struct Resolution{
    int width = 0;
    int height = 0;
};

class VideoMode {
    public: 
        Resolution resolution = Resolution();
        bool interlaced = false;
        double frameRate = 0.0;
        std::optional<std::string> name = nullptr;
};

    
int main(){
    VideoMode vm = VideoMode();
    Resolution res = Resolution();
    double fr = vm.frameRate;
    int px = res.height * res.width;
    return 0;
}