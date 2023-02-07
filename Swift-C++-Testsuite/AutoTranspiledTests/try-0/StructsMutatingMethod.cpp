
 #include <iostream>
 
 using namespace std;
 
 struct Point{
     double x = 0.0, y = 0.0;
     void moveBy(double deltaX, double deltaY){
        x += deltaX;
        y += deltaY;
    }
 };
 
 int main(){
     Point somePoint = {1.0, 1.0};
     somePoint.moveBy(2.0, 3.0);
     cout << "(" << somePoint.x << ", " << somePoint.y << ")" << endl;
 
     return 0;
 }