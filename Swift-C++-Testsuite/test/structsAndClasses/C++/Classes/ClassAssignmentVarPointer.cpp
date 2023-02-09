 
#include <iostream> 

class VideoMode {
    public:
    bool interlaced = false;
    double frameRate = 0.0;
    std::string name = "MyMode";
};

int main(){
    VideoMode vm;
    VideoMode copied = vm;
    copied.interlaced = true;
    copied.frameRate = 2.7;
    return 0;
}