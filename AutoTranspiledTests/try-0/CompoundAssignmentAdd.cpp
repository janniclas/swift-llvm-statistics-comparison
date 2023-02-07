
#include <iostream>
 
 using namespace std;
 
int compoundAssignment(int x) {
    int a = x;
    a += 42;
    return a;
}

int main() {
    int result = compoundAssignment(-1);
    cout << result << endl;
    return 0;
}