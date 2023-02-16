
 #include <iostream>
 #include <future>
#include <vector>
#include <string>
 
int main()
{
    std::vector<std::string> photos;
    auto fut = std::async(std::launch::async, []() {
        return listPhotos("Summer Vacation");
    }
);
    photos = fut.get();
    for (const auto& name : photos) {
        auto f = std::async(std::launch::async, []() {
            return downloadPhoto(name);
        });
        f.get();
    }
    return 0;
}

std::vector<std::string> downloadPhoto(std::string& name) {
    std::vector<std::string> result = {"MyPhoto"};
    // ... some asynchronous networking code ...
    std::this_thread:sleep_for(std::chrono::seconds(2));
    return result;
}

std::vector<std::string> listPhotos(std::string& name) {
    std::vector<std::string> result = {"MyPhotoNames"};
    // ... some asynchronous networking code ...
    std::this_thread:sleep_for(std::chrono::seconds(2));
    return result;

}