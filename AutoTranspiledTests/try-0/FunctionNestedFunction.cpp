 

#include <iostream> 
 
typedef int (StepFunction) (int); 
  
int stepForward(int input) { 
    return input + 1; 
} 
  
int stepBackward(int input) { 
    return input - 1; 
} 
  
StepFunction* chooseStepFunction(bool backward) { 
    return backward ? stepBackward : stepForward; 
} 
  
int main() { 
    // main can be compiled in c++
    int currentValue = 3; 
    StepFunction* func = chooseStepFunction(currentValue > 0); 
  
    return 0; 
} 

  // End