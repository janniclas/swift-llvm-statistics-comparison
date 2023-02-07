 
 # include <iostream> 
 # include <array> 
 
 using namespace std; 
 
 int main()
 {
    array<int, 3> a = { 0, 0, 0 };
    array<int, 3> b = { 2, 3, 4 };
    array<int, 3> c;

    int j = 0; 
    for (const int e: a) c[j++] = e;
    j = 0;
    for (const int e: b) c[j++] += e;

    return 0;
}