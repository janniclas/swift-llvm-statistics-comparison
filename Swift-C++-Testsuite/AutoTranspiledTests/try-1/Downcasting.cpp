
#include <iostream>
using namespace std; 


class MediaItem {
    public:
    string name;
    MediaItem(string name) : name(name){};
};

class Movie : public MediaItem{
    public:
    string director; 
    Movie(string name, string director) : MediaItem(name), director(director){};
}; 

class Song : public MediaItem{
    public: 
    string artist; 
    Song(string name, string artist) : MediaItem(name), artist(artist){};
};

int main(){
    std::vector<MediaItem*> library = { 
        new Movie("Casablanca", "Michael Curtiz"),
        new Song("Blue Suede Shoes", "Elvis Presley"),
        new Movie("Citizen Kane", "Orson Welles"),
        new Song("The One And Only", "Chesney Hawkes"),
        new Song("Never Gonna Give You Up", "Rick Astley")
    }; 
    
    for(auto item : library){
        if(Movie* movie = dynamic_cast<Movie*>(item)){
            cout << "Movie: " << movie->name << ", dir. " << movie->director << endl;
        } else if (Song* song = dynamic_cast<Song*>(item)){
            cout << "Song: " << song->name << ", by " << song->artist << endl;
        }
    }
    return 0;
}