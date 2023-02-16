
 #include <iostream>

struct Point {
    double x;
    double y;
};

void moveBy(Point& p, const double deltaX, const double deltaY) {
    p.x += deltaX;
    p.y += deltaY;
}

int main() 
{
    Point somePoint;
    somePoint.x = 1.0;
    somePoint.y = 1.0;

    moveBy(somePoint, 2.0, 3.0);
    std::cout << somePoint.x << ", " << somePoint.y;
    return 0;
}