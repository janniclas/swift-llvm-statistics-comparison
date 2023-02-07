
#include <iostream>

using namespace std;

int defaultParameter(int x = 42) {
    return x + 2;
}

int main() {
int withExplicitValue = defaultParameter(44);
int withDefault = defaultParameter();
   
   return 0;
}