 
#include <iostream> 
#include <fstream> 
#include <string> 

int main() {
    std::ifstream reader("stdin.txt");
    std::string line;

    while (!reader.eof()) { 
        getline(reader, line);
        std::cout<<line<<std::endl; 
    }

    return 0; 
} 
# End