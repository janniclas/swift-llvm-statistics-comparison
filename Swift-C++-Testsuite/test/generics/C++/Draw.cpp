#include "iostream"
#include <type_traits>

struct Drawable {
  virtual void draw() = 0;
};

struct Point : Drawable {
  double x, y;

  Point (double x, double y): x(x), y(y) {}

  void draw()  override {
    std::cout << "Drawing a point\n";
  }
};

struct Line : Drawable {
  double x1, y1, x2, y2;
  
  Line(double x1, double y1, double x2, double y2): x1(x1), x2(x2), y1(y1), y2(y2) {
  }

  void draw()  override {
    std::cout << "Drawing a line\n";
  }
};

template<typename T>
void drawACopy(T *local) {
    static_assert(std::is_base_of<Drawable, T>::value, "T must inherit from Drawable");
    local->draw();
}

int main() {
  Point P{1.0, 2.0};
  drawACopy(&P);
  Line L{1.0, 2.0, 3.0, 4.0};
  drawACopy(&L);
  return 0;
}