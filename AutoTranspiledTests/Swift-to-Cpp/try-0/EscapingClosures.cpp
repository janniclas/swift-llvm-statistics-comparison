 
#include <iostream>
#include <vector>

// As an optimization, C++ may instead capture and store a copy of
//  a value if that value isn’t mutated by a closure, and if the value
//  isn’t mutated after the closure is created.

// C++ also handles all memory management involved in disposing of
// variables when they’re no longer needed.

int main()
{
    std::vector<void(*)()> completionHandlers;
    void someFunctionWithEscapingClosure(void(*)())
    {
        completionHandlers.push_back(completionHandler);
    }
    for(auto h : completionHandlers)
    {
        h();
    }

}