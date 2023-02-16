

#include <iostream>
#include <string>
 
using namespace std;
 
struct File {
    string name;

    string readline() {
        return "test";
    }
};

 static int main() {
        processFile("testfile.txt");
    return 0;    
}
 
 static void processFile(string filename) {
        if (exists(filename)) {
            File file;
            file.name = filename;
            
            // auto closeFile = [&](){   // if not using c++ 17 use auto 
            auto closeFile = [&file](){ // if using c++ 17 annotate with file
                close(file);
            };
            
            try {
                while (auto line = file.readline()) {
                    // Work with the file.
                }
                closeFile();
            } catch (...) {
                closeFile();
                throw;
            }
        }
    }
     
static bool exists(string fName) {
    return true;
}

static void close(File file) {
    cout << "closed";
}