 
 #include <iostream>
 #include <vector>

 class Container {
 public:
    virtual int count() = 0;
    virtual int get(int index) = 0;
    virtual void append(int item) = 0;
 };

 class IntStack : public Container {
 private:
    std::vector<int> items;
 public:
    void push(int item) {
        items.push_back(item);
    }
    int pop() {
        int item = items.back();
        items.pop_back();
        return item;
    }
    int count() override {
        return items.size();
    }
    int get(int index) override {
        return items[index];
    }
    void append(int item) override {
        this->push(item);
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