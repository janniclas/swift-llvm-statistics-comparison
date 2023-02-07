
 #include <iostream>

using namespace std; 

class MyMain 
{ 
    public: 
    static bool numberEqual(int x) 
    { 
        bool tmp = x == 42;  
        return tmp; 
    } 
    static bool numberNotEqual(int x) 
    { 
        bool tmp = x != 42; 
        return tmp; 
    } 
    static bool numberLarger(int x) 
    { 
        bool tmp = x > 42; 
        return tmp; 
    } 
    static bool numberSmaller(int x) 
    { 
        bool tmp = x < 42; 
        return tmp; 
    }
    static bool numberLargerOrEqual(int x) 
    { 
        bool tmp = x >= 42; 
        return tmp; 
    } 
    static bool numberSmallerOrEqual(int x) 
    { 
        bool tmp = x <= 42; 
        return tmp; 
    }

    public: 
    void main() 
    { 
         bool numberEqual42 = numberEqual(42);    // true 
         bool numberEqual41 = numberEqual(41);    // false 
         bool numberNotEqual42 = numberNotEqual(42);  // false 
         bool numberNotEqual41 = numberNotEqual(41);  // true 
         bool numberLarger43 = numberLarger(43); // true 
         bool numberLarger41 = numberLarger(41); // false  
         bool numberSmaller41 = numberSmaller(41); // true 
         bool numberSmaller43 = numberSmaller(43); // false 
         bool numberLargerOrEqual42 = numberLargerOrEqual(42);  // true 
         bool numberLargerOrEqual41 = numberLargerOrEqual(41);  // false 
         bool numberSmallerOrEqual42 = numberSmallerOrEqual(42);  // true 
         bool numberSmallerOrEqual43 = numberSmallerOrEqual(43);  // false 
    } 
}; 
 
int main() 
{ 
    MyMain myMain; 
    myMain.main(); 
    return 0; 
}