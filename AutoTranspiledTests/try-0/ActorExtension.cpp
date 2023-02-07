
 #include <iostream> 
#include <string>
#include <array>

using namespace std;

class TemperatureLogger { 
    private: 
        string label; 
        array<int, 1000> measurements;
        int max;

    public: 
        TemperatureLogger(string label, int measurement) {
            this->label = label;
            measurements.fill(measurement);
            this->max = measurement;
        }

        void update(int measurement) {
            measurements.push_back(measurement);
            if (measurement > max) {
                max = measurement;
            }
        }

        int getMax() {
            return max;
        }
};

int main() { 

    TemperatureLogger logger = TemperatureLogger("Outdoors", 25);
    int maxTemp = logger.getMax();
    logger.update(25);
    int newMaxTemp = logger.getMax();

    return 0; 
}