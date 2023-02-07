 
 #include <iostream> 
  
using namespace std; 
  
// main function 
int main() 
{ 
    // Variables declaration 
    int counter = 0; 
    int max = 7; 
    pair<int, int> input = make_pair(2, 3); 
  
    // Switch over the pair 
    switch (input) { 
  
    // Case when x = 0 
    case make_pair(0, int y):  
        counter = -y; 
        break; 
  
    // Case when y = 0 
    case make_pair(int x, 0):  
        counter = x; 
        break; 
  
    // Case when x and y are equal 
    case make_pair(int x, y):  
        if (x == y) 
            counter = -x; 
        break; 
  
    // Default case 
    default:  
        counter = -1; 
    } 
  
    cout << counter; 
  
    return 0; 
}