 
 #include <iostream> 
using namespace std; 
int main()  
{    
    int customersInLine[7] = {1, 2, 3, 4, 5, 6, 42}; 
 
    // serve function 
    auto serve = [&]() -> int             
    { 
        int tmp = customersInLine[0]; 
        for (int i = 0; i <= 6; i++) 
            customersInLine[i] = customersInLine[i + 1]; 
        return tmp; 
    }; 
     
    auto customerProvider = serve(); 
    
    cout << customerProvider; 
 
    return 0; 
}