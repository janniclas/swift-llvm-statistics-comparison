
#include <iostream>
#include <string>
#include <vector>

class MediaItem {
public: 
   std::string name;
   MediaItem(std::string name_) : name(name_) {};
};

class Movie : public MediaItem { 
public:
   std::string director;
   Movie(std::string name_, std::string director_) : MediaItem(name_), director(director_) {};
};

class Song : public MediaItem {
public: 
   std::string artist;
   Song(std::string name_, std::string artist_) : MediaItem(name_), artist(artist_) {};
};

int main() {
    std::vector<MediaItem*> library = {
        new Movie("Casablanca", "Michael Curtiz"),
        new Song("Blue Suede Shoes", "Elvis Presley"),
        new Movie("Citizen Kane", "Orson Welles"),
        new Song("The One And Only", "Chesney Hawkes"),
        new Song("Never Gonna Give You Up", "Rick Astley")
    };
    int movieCount = 0;
    int songCount = 0; 
    for (auto item : library) {
        if (dynamic_cast<Movie*>(item) != NULL) { 
            movieCount++;
        } else if (dynamic_cast<Song*>(item) != NULL) {
            songCount++;
        }       
    }

    std::cout << "Media library contains " << movieCount << " movies and " << songCount << " songs" << std::endl;

    return 0;

}