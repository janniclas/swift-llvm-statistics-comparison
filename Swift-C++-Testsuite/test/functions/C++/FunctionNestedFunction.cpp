
typedef int (StepFunction) (int); 
  
StepFunction* chooseStepFunction(bool backward) {
    auto stepForward = [](int input) {
        return input + 1;
    };
    auto stepBackward = [](int input) {
        return input - 1;
    };
    return backward ? stepBackward : stepForward; 
} 
  
int main() { 
    // main can be compiled in c++
    int currentValue = 3; 
    StepFunction* func = chooseStepFunction(currentValue > 0); 
  
    return 0; 
} 

  // End