
#include <iostream>

class VideoMode {
    public: 
        Resolution resolution = Resolution();
        bool interlaced = false;
        double frameRate = 0.0;
        std::string name = NULL;
};

 struct Resolution{
    int width = 0;
    int height = 0;
};
    
int main(){
    VideoMode vm = VideoMode();
    Resolution res = Resolution();
    double fr = vm.frameRate;
    int px = res.height * res.width;
    return 0;
}