 
#include <iostream>
 
struct Point 
{ 
    double x, y; 
}; 
 
struct Size
{ 
    double width, height; 
}; 
 
struct Rect
{ 
    Point origin; 
    Size size; 
    
    Rect() {} 
    
    Rect(Point origin, Size size) 
    { 
        this->origin = origin; 
        this->size = size; 
    } 
  
    Rect(Point center, Size size) 
    { 
        origin.x = center.x - (size.width / 2); 
        origin.y = center.y - (size.height / 2); 
    
        this->size = size; 
    } 
}; 
 
int main() 
{ 
    Rect basicRect; 
    Point p = {2.0, 2.0}; 
    Size s = {5.0, 5.0}; 
    Rect originRect(p, s); 
  
    return 0; 
}