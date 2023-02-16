
#include<thread>
#include<future>
#include<iostream>
#include<chrono>

std :: vector<std::string> listPhotos(std::string name) {
    std::vector<std::string> result = {"MyPhotoNames"}; 
    std::this_thread::sleep_for(std::chrono::seconds(2));
    return result;
}

int main(){
    std::vector<std::future<std::vector<std::string>>> photos;
    photos.emplace_back( std::async(listPhotos, "first" ) );
    photos.emplace_back( std::async(listPhotos, "second") );
    photos.emplace_back( std::async(listPhotos, "third" ));

    for (auto & in : photos) {
        std::cout << in.get() << std::endl;
    }
    return 0;
}