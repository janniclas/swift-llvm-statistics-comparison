
#include <iostream>
#include <vector>
#include <algorithm>

class TemperatureLogger {
public:
    std::string label;
    std::vector<int> measurements;
    int max;

    TemperatureLogger(std::string label, int measurement) : label(label), measurements(std::vector<int>{measurement}), max(measurement) {};

    void update(int measurement){
        measurements.push_back(measurement);
        max = std::max(max, measurement);
    }
};

int main()
{
    TemperatureLogger logger("Outdoors", 25);
    int maxTemp = logger.max;
    logger.update(25);
    int newMaxTemp = logger.max;    

    return 0;
}