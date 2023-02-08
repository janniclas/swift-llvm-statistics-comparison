
struct Point {
    Point() {}
    Point(double a, double b) {
        x = a; y = b;
    }
    double x = 0.0, y = 0.0;
};
struct Size {
        Size() {}
    Size(double a, double b) {
        width = a; height = b;
    }
    double width = 0.0, height = 0.0;
};
struct Rect {
    Point origin = Point();
    Size size = Size();
    Point getCenter() {
        double centerX = origin.x + (size.width / 2);
        double centerY = origin.y + (size.height / 2); 
        return Point( centerX,  centerY);
    }
    void setCenter(Point newCenter) {
        origin.x = newCenter.x - (size.width / 2);
        origin.y = newCenter.y - (size.height / 2);
    }
};


int main() {
    Rect square = Rect();
    square.origin = Point( 0.0, 0.0);
    square.size = Size( 10.0, 10.0);
    Point initialSquareCenter = square.getCenter();
    // initialSquareCenter is at (5.0, 5.0)
    square.setCenter(Point( 15.0,  15.0));
    return 0;
}