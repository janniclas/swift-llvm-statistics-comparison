
#include<vector>

class MediaItem {
    public:
        std::string name;
        MediaItem(std::string name){
            this->name = name;
        }
};

class Movie : public MediaItem {
    public:
        std::string director;
        Movie(std::string name, std::string director): MediaItem(name) {
            this->director = director;
        } 
};

auto things = std::vector<std::any>();

int main(){
    things.push_back(0);
    things.push_back(0.0);
    things.push_back(42);
    things.push_back(3.14159);
    things.push_back(std::string("hello"));
    things.push_back(std::tuple(3.0, 5.0));
    things.push_back(Movie("Ghostbusters", "Ivan Reitman"));
    things.push_back([](std::string name)->std::string {return "Hello, "+name;});
}