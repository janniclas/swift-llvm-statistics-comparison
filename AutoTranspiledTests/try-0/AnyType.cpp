
#include <vector>
#include <iostream>
using namespace std;

class MediaItem {
    public: 
        string name;
        MediaItem(string name) {
            this->name = name;
        }
};

class Movie : public MediaItem {
    public:
        string director;
        Movie(string name, string director) : MediaItem(name) {
            this->director = director;
        }

};

int main() {
    vector<any> things;

    things.push_back(0);
    things.push_back(0.0);
    things.push_back(42);
    things.push_back(3.14159);
    things.push_back("hello");
    things.push_back(make_pair(3.0, 5.0));
    things.push_back(Movie("Ghostbusters", "Ivan Reitman"));
    things.push_back([](string name) { return "Hello, " + name; });

    return 0;

}