
 #include <iostream>
 
 int main() {
     std::cout << simpleReminder(43);
 
     return 0;
 }
 
 int simpleReminder(int x) {
     int a = x;
     int b = a % 2;
     return b;
 }