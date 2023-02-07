 

#include <vector>
#include <string>
#include <thread>

struct MyMain
{
    static void main()
    {
        DataManager manager;
        manager.data.push_back("Some data");
        manager.data.push_back("Some more data");

        std::string retriveLazyVar = manager.importer.filename;
    }
};

class DataImporter
{
    // DataImporter is a class to import data from an external file. 
    // The class is assumed to take a nontrivial amount of time to initialize.
public:
    std::string filename = "data.txt";
    // the DataImporter class would provide data importing functionality here
};

class DataManager
{
public:
    DataImporter importer; //not lazy initialization
    std::vector<std::string> data;
    // the DataManager class would provide data management functionality here
};