
#include <iostream> 
#include <string>
#include <vector>

using namespace std;

class MediaItem {
    public:
        string name; 
        MediaItem(string n) {
            name = n;
        }
};

class Movie : public MediaItem {
    public: 
        string director;
        Movie(string n, string d) : MediaItem(n) {
            director = d; 
        }
};

class Song : public MediaItem {
    public: 
        string artist;
        Song(string n, string a) : MediaItem(n) {
            artist = a; 
        }
};

int main() { 
    vector<MediaItem*> library;  
    library.push_back(new Movie("Casablanca", "Michael Curtiz")); 
    library.push_back(new Song("Blue Suede Shoes", "Elvis Presley")); 
    library.push_back(new Movie("Citizen Kane", "Orson Welles")); 
    library.push_back(new Song("The One And Only", "Chesney Hawkes"));
    library.push_back(new Song("Never Gonna Give You Up", "Rick Astley"));
     
    auto movie = library[0]; 
    auto song = library[1];
    auto movieName = movie->name; 
    auto songName  = song->name; 
    
    return 0; 
}