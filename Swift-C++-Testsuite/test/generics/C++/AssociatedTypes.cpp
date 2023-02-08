#include <vector>

template <typename T>
class Container {
public:
    virtual void append(const T& item) = 0;
    virtual int count() const = 0;
    virtual T operator[](int i) const = 0;
};

struct IntStack : Container<int> {
    std::vector<int> items;

    void push(int item) {
        items.push_back(item);
    }

    int pop() {
        int last = items.back();
        items.pop_back();
        return last;
    }

    void append(const int& item) override {
        push(item);
    }

    int count() const override {
        return items.size();
    }

    int operator[](int i) const override {
        return items[i];
    }
};



 int main() {
    IntStack stackOfNumbers;
    stackOfNumbers.push(1);
    stackOfNumbers.push(2);
    stackOfNumbers.push(3);
    stackOfNumbers.push(4);

    return 0;
 }