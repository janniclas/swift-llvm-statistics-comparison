
  struct MyMain {
  
      static void main() {
          IntStack stackOfNumbers;
          stackOfNumbers.push(1);
          stackOfNumbers.push(2);
          stackOfNumbers.push(3);
          stackOfNumbers.push(4);
  
      }
  };

struct IntStack {
    std::vector<int> items;

    void push(int item) {
        items.push_back(item);
    }

    int pop() {
        int item = items.back();
        items.pop_back();
        return item;
    }

    int count() {
        return items.size();
    }

    int& operator[](int i) {
        return items[i];
    }
};