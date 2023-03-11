#include "iostream"

class Drawable {
  public:
    virtual void draw() = 0;
};

class Point : public Drawable {
  public:
    double x, y;

    Point (double x, double y): x(x), y(y) {}

    void draw()  override {
      std::cout << "Drawing a point\n";
    }
};

class Line : public Drawable {
  public:
    double x1, y1, x2, y2;
    
    Line(double x1, double y1, double x2, double y2): x1(x1), x2(x2), y1(y1), y2(y2) {
    }

    void draw()  override {
      std::cout << "Drawing a line\n";
    }
};

void callCB(Drawable *F) { F->draw(); }

int main() {
  Point P{1.0, 2.0};
  callCB(&P);
  Line L{1.0, 2.0, 3.0, 4.0};
  callCB(&L);
  return 0;
}
