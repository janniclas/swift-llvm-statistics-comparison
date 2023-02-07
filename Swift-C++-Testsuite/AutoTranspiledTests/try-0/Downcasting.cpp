
#include<vector>
#include<iostream>
#include<string>

class MediaItem {
public:
  std::string name;
  MediaItem(std::string name) {
    this->name = name;
  }
}; 

class Movie : public MediaItem {
public:
  std::string director;
  Movie(std::string name, std::string director) : MediaItem(name) {
    this->director = director;
  }
}; 

class Song : public MediaItem {
public:
  std::string artist;
  Song(std::string name, std::string artist) : MediaItem(name) {
    this->artist = artist;
  }
}; 

int main() {
  std::vector<MediaItem*> library = {
    new Movie("Casablanca", "Michael Curtiz"),
    new Song("Blue Suede Shoes", "Elvis Presley"),
    new Movie("Citizen Kane", "Orson Welles"),
    new Song("The One And Only", "Chesney Hawkes"),
    new Song("Never Gonna Give You Up", "Rick Astley")
  };
  // type of "library" is inferred to be vector<MediaItem*>
  for ( auto item : library ) {
    Movie* movie = dynamic_cast<Movie*>(item);
    if ( movie != nullptr ) {
      std::cout << "Movie: " << movie->name << ", dir. " << movie->director << std::endl;
    }

    Song* song = dynamic_cast<Song*>(item);
    if ( song != nullptr ) {
      std::cout << "Song: " << song->name << ", by " << song->artist << std::endl;
    }
  }  
  delete movie;
  delete song;
  library.erase( library.begin(), library.end() );
  return 0;
 
}