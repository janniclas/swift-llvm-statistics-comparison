
#include <chrono>
#include <iostream>
#include <thread>
#include <vector>

struct MyMain {
  static std::vector<std::string> listPhotos(std::string name) {
    std::vector<std::string> result = {"MyPhotoNames"};
    //... some asynchronous networking code ...
    try {
      std::this_thread::sleep_for(std::chrono::seconds(2));
    } catch (std::exception &e) {
      std::cerr << "Sleep failed" << std::endl;
    }
    return result;
  }

 static int main() {
  std::vector<std::string> photos = listPhotos("home");
  return 0;
 }
};

int main() {
  MyMain::main();
  return 0;
}