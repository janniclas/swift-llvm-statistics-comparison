
# include <iostream>

// As an optimization, C++ may instead capture and store a copy of
//  a value if that value isn’t mutated by a closure, and if the value
//  isn’t mutated after the closure is created.

// C++ also handles all memory management involved in disposing of
// variables when they’re no longer needed.

int main(){
    auto incrementer = [](int x){ return x + 5; };
    void explicitClosure([](int)(int)myFunction) {
        myFunction(5);
    }
    explicitClosure(incrementer);
    explicitClosure([](int x){ return x + 5; };);
    return 0;
}