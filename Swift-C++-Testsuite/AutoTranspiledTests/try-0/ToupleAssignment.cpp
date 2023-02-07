

#include<iostream>

using namespace std;
 
struct simpleAssignment {
    
    static void main() {
        pair<int, int> b(1, 2);
        pair<int, int> a(2, 4);
        a = b;
    }
};

int main() {
    simpleAssignment::main();
    return 0;
}