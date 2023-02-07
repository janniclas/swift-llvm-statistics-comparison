

#include <iostream>
#include <algorithm>

struct SmallNumber {
    int maximum;
    int number;

    int getWrappedValue() { return number; }
    void setWrappedValue(int newValue) { number = std::min(newValue, maximum); }

    SmallNumber() {
        maximum = 12;
        number = 0;
    }
    SmallNumber(int wrappedValue) {
        maximum = 12;
        number = std::min(wrappedValue, maximum);
    }
    SmallNumber(int wrappedValue, int maximum) {
        this->maximum = maximum;
        number = std::min(wrappedValue, maximum);
    }
};

struct ZeroRectangle {
    SmallNumber height;
    SmallNumber width;
};

struct UnitRectangle {
    SmallNumber height = SmallNumber(1);
    SmallNumber width = SmallNumber(1);
};

struct MixedRectangle {
    SmallNumber height = SmallNumber(1);
    SmallNumber width = SmallNumber(2, 9);
};

int main() {
    ZeroRectangle rectangle;
    UnitRectangle unitRectangle;
    MixedRectangle mixedRectangle;
    mixedRectangle.width.setWrappedValue(12);
    return 0;
}