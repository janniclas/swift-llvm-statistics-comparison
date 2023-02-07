
#include <iostream>
#include <string>

struct File {
    std::string name;
 
    std::string readline(){
        return "test";
    }

    ~File() {
        close();
    }
private: 
     std::string close() {
        return "closed";
    }
};
 
    static bool exists(std::string fName) {
        return true;
    }
 
    static File open(std::string fName) {
        return File{fName};
    }
 
    static void processFile(std::string filename) {
        if (exists(filename)) {
            File file = open(filename);


                std::string line = file.readline();
                // work with the file
      
        }
    }



int main(){
           processFile("testfile.txt");
}