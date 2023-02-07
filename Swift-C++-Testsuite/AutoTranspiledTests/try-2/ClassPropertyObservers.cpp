
 struct MyMain {
   static void main() {
     StepCounter stepCounter;
     stepCounter.totalSteps = 200;
   }
 };
 
 class StepCounter {
 
 public:
   int totalSteps = 0;
 
   StepCounter() {
 
   }
 
   void setTotalSteps(int new_total_steps) {
     this->willSet(new_total_steps);
     totalSteps = new_total_steps;
     this->didSet();
   }
 
 private:
   void willSet(int newTotalSteps) {
     std::cout << "About to set totalSteps to " << newTotalSteps << std::endl;
   }
 
   void didSet() {
     int oldValue = totalSteps - (totalSteps - oldValue);
     if (totalSteps > oldValue) {
       std::cout << "Added " << totalSteps - oldValue << " steps" << std::endl;
     }
   }
 };