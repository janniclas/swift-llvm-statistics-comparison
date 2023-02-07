
#include <iostream>
#include <string>
#include <vector>

class TemperatureLogger {
    public:
        TemperatureLogger(const std::string &label, int measurement) 
        : label(label) {
            measurements.push_back(measurement);
            max = measurement;
        }

        std::string getLabel() {
            return label;
        }

        std::vector<int> getMeasurements(){
            return measurements;
        }

        int getMax() {
            return max;
        }

    private:
        std::string label;
        std::vector<int> measurements;
        int max;
};


int main() {
    TemperatureLogger logger("Outdoors", 25);
    int maxTemp = logger.getMax();
    return 0;
}