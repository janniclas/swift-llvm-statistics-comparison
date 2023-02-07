 
#include <iostream>

struct Point {
    double x = 0.0, y = 0.0;
    bool isToTheRightOf(double x) {
        return (this->x > x);
    }
};

int main() {
    Point somePoint {4.0, 5.0};
    if (somePoint.isToTheRightOf(1.0)) 
        int something {42};

    return 0;
}