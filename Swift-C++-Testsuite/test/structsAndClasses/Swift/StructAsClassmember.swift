@main
struct MyMain {

    static func main() {
        let vm = VideoMode()
    }
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

struct Resolution {
    var width = 0
    var height = 0
}

// #include <iostream>
// #include <string>

// class Resolution {
// public:
//     int width = 0;
//     int height = 0;
// };

// class VideoMode {
// public:
//     Resolution resolution = Resolution();
//     bool interlaced = false;
//     double frameRate = 0.0;
//     std::string name;
// };

// int main() {
//     VideoMode vm;
//     return 0;
// }
