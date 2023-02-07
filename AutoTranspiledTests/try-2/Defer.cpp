
#include <iostream>
#include <string>

struct File {
    std::string name;
 
    std::string readline(){
        return "test";
    }
};

struct MyMain {
    static void main(){
        processFile("testfile.txt");
    }
 
    static void processFile(std::string filename) {
        if (exists(filename)) {
            File file = open(filename);
            auto _ = [&file](){
                close(file);
            }; 
            while(true) {
                std::string line = file.readline();
                if (line.empty()) break;
                // work with the file
            }
        }
    }
 
    static bool exists(std::string fName) {
        return true;
    }
 
    static File open(std::string fName) {
        return File{fName};
    }
 
    static std::string close(File file) {
        return "closed";
    }
};

int main(){
    MyMain::main();
}