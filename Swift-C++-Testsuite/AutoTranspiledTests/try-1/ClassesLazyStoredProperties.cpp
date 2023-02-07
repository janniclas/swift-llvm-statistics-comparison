
#include <string>
#include <vector>

class DataImporter 
{
   /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    std::string filename = "data.txt";
    // the DataImporter class would provide data importing functionality here
public:
   DataImporter() {}
   ~DataImporter() {}
};

class DataManager
{
    DataImporter* importer;
    // the DataManager class would provide data management functionality here

public:
    DataManager() : importer(nullptr) {}
    ~DataManager() 
    { 
        if (importer != nullptr) 
            delete importer; 
 
    }

    DataImporter* getImporter()
    {
        // If a property marked with the lazy modifier is accessed by
        // multiple threads simultaneously and the property hasn’t yet
        // been initialized, there’s no guarantee that the property
        // will be initialized only once.
        if (!importer) 
        {
            importer = new DataImporter();
        }
        return importer;
    }

    std::vector<std::string> data;
};

int main() 
{
    DataManager manager;
    manager.data.push_back("Some data");
    manager.data.push_back("Some more data");

    DataImporter* retriveLazyVar = manager.getImporter();

    return 0;

}