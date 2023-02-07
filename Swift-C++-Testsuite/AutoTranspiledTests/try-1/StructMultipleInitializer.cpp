 
struct MyMain {

    static void main() {
        Rect basicRect;
        Rect originRect(Point(2.0, 2.0), Size(5.0, 5.0));
    }
};

struct Rect {
    Point origin;
    Size size;
    Rect() {}
    Rect(Point origin, Size size) : origin(origin), size(size) {}
    Rect(Point center, Size size) {
        double originX = center.x - (size.width / 2);
        double originY = center.y - (size.height / 2);
        origin = Point(originX, originY);
        this->size = size;
    }
};

struct Size {
    double width = 0.0, height = 0.0;
};

struct Point {
    double x = 0.0, y = 0.0;
};