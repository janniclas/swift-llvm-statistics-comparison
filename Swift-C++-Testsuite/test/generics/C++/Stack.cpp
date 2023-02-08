 
#include <iostream>
#include <vector>
 
template<typename T>
struct Stack {
    std::vector<T> items;
 
    void push(T item) {
        items.push_back(item);
    }
 
    T pop() {
        T item = items.back();
        items.erase(items.end()-1);
        return item;
    }
};
 
int main() {
    Stack<std::string> stackOfStrings;
    stackOfStrings.push("uno");
    stackOfStrings.push("dos");
    stackOfStrings.push("tres");
    stackOfStrings.push("cuatro");
 
    Stack<int> stackOfNumbers;
    stackOfNumbers.push(1);
    stackOfNumbers.push(2);
    stackOfNumbers.push(3);
    stackOfNumbers.push(4);
}