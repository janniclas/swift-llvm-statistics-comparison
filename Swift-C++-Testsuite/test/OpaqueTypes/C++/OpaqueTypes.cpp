

#include <iostream>
#include <string>
#include <algorithm>

class Shape
{
public:
    virtual std::string draw() = 0;
};

class Square : public Shape
{
private:
    int size;

public:
    Square(int size) : size(size) {};

    std::string draw() {
        std::string line = std::string(size, '*');
        std::string result = line;
        for (int i = 1; i < size; i++) result += ('\n' + line); 
        return result;
    }
};

class Triangle : public Shape
{
private:
    int size;

public:
    Triangle(int size) : size(size) {};

    std::string draw() {
        std::string result;
        for (int i = 1; i <= size; i++) {
            result += std::string(i, '*');
            if (i < size) result += '\n';
        } 
        return result;
    }
};

template <typename T>
class FlippedShape : public Shape
{
private:
    T shape;

public:
    FlippedShape(T shape) : shape(shape) {};

    std::string draw() {
        std::string lines = shape.draw();
        std::reverse(lines.begin(), lines.end());
        return lines;
    }
};

template <typename T, typename U>
class JoinedShape : public Shape
{
private:
    T top;
    U bottom;

public:
    JoinedShape(T top, U bottom) : top(top), bottom(bottom) {};

    std::string draw() {
        return top.draw() + '\n' + bottom.draw(); 
    }
};

Shape* makeTrapezoid()
{
    Triangle top(2);
    Square middle(2);
    FlippedShape<Triangle> bottom(top);
    JoinedShape<Triangle, JoinedShape<Square, FlippedShape<Triangle>>> trapezoid(top, JoinedShape<Square, FlippedShape<Triangle>>(middle, bottom));
    return &trapezoid;
}

int main() {
    Shape* trapezoid = makeTrapezoid();
    std::cout << trapezoid->draw();
    return 0;
}