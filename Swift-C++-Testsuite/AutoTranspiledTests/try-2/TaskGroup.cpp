
 #include <chrono>
 #include <future>
 #include <functional>
 #include <iostream>
 #include <vector>

class MyMain {
public:
    static void main() {
        std::vector<std::string> taskGroup; 
        std::async(std::launch::async, &MyMain::listPhotos, "Summer Vacation").then([&taskGroup](std::vector<std::string> photoNames){
            for (auto &name : photoNames) {
                taskGroup.push_back(name);
            }
        });
    }

    static std::future<std::vector<std::string>> downloadPhoto(std::string name) {
        auto result = std::make_shared<std::vector<std::string>>();
        result -> push_back("MyPhoto");
        std::this_thread::sleep_for(std::chrono::seconds(2));
        std::cout << "Sleep failed" << std::endl;
        return std::async(std::launch::async, [result](){ return *result; });
    }

    static std::future<std::vector<std::string>> listPhotos(std::string name) {
        auto result = std::make_shared<std::vector<std::string>>();
        result -> push_back("MyPhotoNames");
        std::this_thread::sleep_for(std::chrono::seconds(2));
        std::cout << "Sleep failed" << std::endl;
        return std::async(std::launch::async, [result](){ return *result; });
    }
};

int main(){
    MyMain::main();
}