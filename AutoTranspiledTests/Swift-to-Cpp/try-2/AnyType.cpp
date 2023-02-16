
#include<iostream>
#include<string>
#include<vector>
#include<any>

class MediaItem
{
public:
    std::string name;
    MediaItem(std::string name)
    {
        name = name;
    }
};

class Movie : public MediaItem
{
public:
    std::string director;
    Movie(std::string name, std::string director) : MediaItem(name)
    {
        director = director;
    }
};

int main()
{
    std::vector<std::any> things;
    things.push_back(0);
    things.push_back(0.0);
    things.push_back(42);
    things.push_back(3.14159);
    things.push_back("hello");
    things.push_back(std::make_pair(3.0, 5.0));
    things.push_back(Movie("Ghostbusters", "Ivan Reitman"));
    auto lambda = [](std::string name) -> std:: string { return "Hello, " + name; };
    things.push_back(lambda);

    return 0;
}