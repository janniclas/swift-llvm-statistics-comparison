 
// If a property marked with the lazy modifier is accessed by
// multiple threads simultaneously and the property hasn’t yet
// been initialized, there’s no guarantee that the property
// will be initialized only once.

struct Point {
    double x = 0.0, y = 0.0;
};

struct Size {
    double width = 0.0, height = 0.0;
};

struct Rect {
    Point origin;
    Size size;
    Point const getCenter(){
        double centerX = origin.x + (size.width / 2);
        double centerY = origin.y + (size.height / 2);
        return Point{centerX, centerY};
    } 
    void setCenter(Point const& newCenter){
        origin.x = newCenter.x - (size.width / 2);
        origin.y = newCenter.y - (size.height / 2);
    } 
};

int main() {
    Rect square = {Point(0.0, 0.0), Size(10.0, 10.0)};
    Point initialSquareCenter = square.getCenter();
    // initialSquareCenter is at (5.0, 5.0) 
    square.setCenter(Point(15.0, 15.0));
    return 0;
}