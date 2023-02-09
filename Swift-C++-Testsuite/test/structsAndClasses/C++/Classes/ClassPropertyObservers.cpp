
#include <iostream>
class StepCounter {
public:
    int totalSteps;
    StepCounter() {
        totalSteps = 0;
    }
    void setTotalSteps(int newTotalSteps) {
        std::cout<<"About to set totalSteps to "<<newTotalSteps<<std::endl;
        if (totalSteps > newTotalSteps) {
            std::cout<<"Added "<<totalSteps -newTotalSteps<<" steps"<<std::endl;
        }
        totalSteps = newTotalSteps;
    }
};

int main() {
        StepCounter stepCounter;
        stepCounter.totalSteps = 200;
}
