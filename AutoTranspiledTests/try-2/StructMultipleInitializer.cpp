
int main() {
  Rect basicRect = Rect();
  Rect originRect = Rect(Point(2.0, 2.0), Size(5.0, 5.0));
  
  return 0;
}

class Rect {
public:
  Point origin;
  Size size;
  Rect() {};
  Rect(Point origin, Size size) {
    this->origin = origin;
    this->size = size;
  }
  Rect(Point center, Size size) {
    double originX = center.x - (size.width / 2);
    double originY = center.y - (size.height / 2);
    this -> init(Point(originX, originY), size); 
   }
};

class Size {
public:
  double width = 0.0, height = 0.0;
};

class Point {
public: 
  double x = 0.0, y = 0.0;
};