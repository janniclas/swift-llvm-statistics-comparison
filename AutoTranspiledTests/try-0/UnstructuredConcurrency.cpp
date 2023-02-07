 
#include <iostream> 
#include <chrono>
#include <future>
#include <thread>
#include <vector>
#include <string>
  
using namespace std;
std::vector<std::string> listPhotos(std::string name) 
{
    std::vector<std::string> result; 
    result.push_back("MyPhotoNames");

    try
    {
        auto start = std::chrono::high_resolution_clock::now();
        auto start_sec = std::chrono::time_point_cast<std::chrono::seconds>(start);
        auto current = std::chrono::high_resolution_clock::now();
        auto end = start_sec + std::chrono::seconds(2);
        while (current < end)
        {
            current = std::chrono::high_resolution_clock::now();
        }
    }
    catch (...)
    {
        std::cerr << "Sleep failed..." << std::endl;
    }
    return result; 
}  

int main() 
{ 
    std::future<std::vector<std::string>> handle = std::async(listPhotos, "test gallery");
    std::vector<std::string> result  = handle.get();
    std::cout << "Result: " << result[0] << std::endl;
    return 0; 
}