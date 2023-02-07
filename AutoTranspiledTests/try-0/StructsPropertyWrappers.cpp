
#include <iostream>
#include <algorithm>

class TwelveOrLess
{
private:
    int number = 0;
public:
    int getNumber(){
        return number;
    }
    void setNumber(int newValue){
        number = std::min(newValue, 12);
    }
};

struct SmallRectangle
{
    TwelveOrLess height;
    TwelveOrLess width;
};

int main(){
    SmallRectangle rectangle;
    rectangle.height.setNumber(10);
    std::cout << rectangle.height.getNumber() << std::endl;
    return 0;
}