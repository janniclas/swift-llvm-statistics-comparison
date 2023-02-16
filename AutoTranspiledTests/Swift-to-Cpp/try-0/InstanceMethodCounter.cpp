
#include <iostream>

class Counter
{
    int count = 0;
public:
    int get_count() { return count; }
    void increment() { count += 1; }
    void increment(int amount) { count += amount; }
    void reset() { count = 0; }
};

int main()
{
    Counter c;
    c.increment();
    c.increment(20);
    c.reset();
    c.increment();
    int currentCount = c.get_count();
}