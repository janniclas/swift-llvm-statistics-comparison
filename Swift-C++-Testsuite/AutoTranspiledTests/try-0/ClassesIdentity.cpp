 

#include <iostream> 
using namespace std; 

struct VideoMode {
    bool interlaced = false;
    double frameRate = 0.0;
    string name = "My Mode";
};

int main() {
    VideoMode vm;
    VideoMode *copied = &vm; 
    copied -> interlaced = true;
    copied -> frameRate = 2.7;
    bool identity = &vm == copied;
    return 0;
}