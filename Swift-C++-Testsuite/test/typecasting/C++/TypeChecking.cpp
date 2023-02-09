

#include <iostream> 
#include <vector> 

using namespace std; 

class MediaItem {
  public:
    string name;
    MediaItem(string name) {
      this->name = name;
    }
    virtual string whoAmI() = 0;
};

class Movie : public MediaItem {
  public:
    string director; 
    Movie(string name, string director) : MediaItem(name) {
      this->director = director; 
    }
    string whoAmI() {
      return "Movie";
    }
};

class Song : public MediaItem {
  public:
    string artist; 
    Song(string name, string artist) : MediaItem(name) {
      this->artist = artist; 
    }

    string whoAmI() {
      return "Song";
    }
};

int main() {
    vector<MediaItem*> library {
    new Movie("Casablanca", "Michael Curtiz"), 
    new Song("Blue Suede Shoes", "Elvis Presley"), 
    new Movie("Citizen Kane", "Orson Welles"), 
    new Song("The One And Only", "Chesney Hawkes"), 
    new Song("Never Gonna Give You Up", "Rick Astley")
    };

    int movieCount = 0; 
    int songCount = 0; 
    
    for (auto item : library) {
      if (Movie* movie = dynamic_cast<Movie*>(item)) { // casting the item 
          movieCount++;
      } else if (Song* song = dynamic_cast<Song*>(item)) {
          songCount++;
      }
    }
    
    cout << "Media library contains " << movieCount << " movies and " << songCount << " songs";
  for (auto item: library) {
          delete item;
  }
    return 0; 
}