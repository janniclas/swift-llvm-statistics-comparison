
#include <iostream>
#include <vector>

class MediaItem
{
    protected:
        std::string name;
    public:
        MediaItem(std::string name):name{name}{}
        virtual std::string getName() = 0;
};

class Movie : public MediaItem
{
    private:
        std::string director;
    public:
        Movie(std::string name, std::string director) : director{director}, MediaItem{name}{}
        std::string getDirector() {return director;}
        std::string getName() {
            return name;
        }
};

class Song : public MediaItem
{
     private:
        std::string artist;
    public:
        Song(std::string name, std::string artist) : artist{artist},MediaItem{name}{}
        std::string getArtist() {return artist;}
                std::string getName() {
            return name;
        }
};

int main()
{
    std::vector<MediaItem*> library {
        new Movie("Casablanca", "Michael Curtiz"),
        new Song("Blue Suede Shoes", "Elvis Presley"),
        new Movie("Citizen Kane", "Orson Welles"),
        new Song("The One And Only", "Chesney Hawkes"),
        new Song("Never Gonna Give You Up", "Rick Astley")
    };
   
    for(auto item : library) {
        Movie* movie = dynamic_cast<Movie*>(item);
        if(movie != nullptr) 
            std::cout << "Movie: " << movie->getName()
            << ", dir. " << movie->getDirector() << std::endl;
        else {
            Song* song = dynamic_cast<Song*>(item);
            std::cout << "Song: " << song->getName() << ", by "
            << song->getArtist() << std::endl;
        }
    }
}