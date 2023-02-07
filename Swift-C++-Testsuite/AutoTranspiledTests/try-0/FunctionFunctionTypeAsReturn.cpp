
 #include<iostream>
 
 int currentValue = 3; 
 
 bool chooseStepFunction(bool backward) {
      return backward ? true: false;
 }
 
 int stepForward(int input) {
     return input + 1;
 }

 int stepBackward(int input) {
     return input - 1;
 }
 
 int main() {
     bool moveNearerToZero = chooseStepFunction(currentValue > 0);
 }