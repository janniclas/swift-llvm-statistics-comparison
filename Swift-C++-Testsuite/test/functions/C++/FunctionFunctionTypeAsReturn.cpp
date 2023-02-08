
 #include<iostream>
 
 int stepForward(int input) {
     return input + 1;
 }

 int stepBackward(int input) {
     return input - 1;
 }
 
 std::function<int (int)> chooseStepFunction(bool backward) {
      return backward ? stepBackward: stepForward;
 }
 

 
 int main() {
     
    int currentValue = 3; 
     std::function<int (int)> moveNearerToZero = chooseStepFunction(currentValue > 0);
 }