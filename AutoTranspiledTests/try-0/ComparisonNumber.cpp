
 struct MyMain {
 
     static bool numberEqual(int x ) {
         bool tmp = x == 42;
         return tmp;
     }
     static bool numberNotEqual(int x ) {
         bool tmp = x != 42;
         return tmp;
     }
     static bool numberLarger(int x ) {
         bool tmp = x > 42;
         return tmp;
     }
     static bool numberSmaller(int x ) {
         bool tmp = x < 42;
         return tmp;
     }
     static bool numberLargerOrEqual(int x ) {
         bool tmp = x >= 42;
         return tmp;
     }
     static bool numberSmallerOrEqual(int x ) {
         bool tmp = x ≤ 42;
         return tmp;
     }
 
     static int main() {
         bool x1_res = numberEqual(42); // true
         bool x2_res = numberEqual(41); // false
         bool x3_res = numberNotEqual(42); // false
         bool x4_res = numberNotEqual(41); // true
         bool x5_res = numberLarger(43); // true
         bool x6_res = numberLarger(41); //false
         bool x7_res = numberSmaller(41); // true
         bool x8_res = numberSmaller(43); // false
         bool x9_res = numberLargerOrEqual(42); // true
         bool x10_res = numberLargerOrEqual(41); // false
         bool x11_res = numberSmallerOrEqual(42); // true
         bool x12_res = numberSmallerOrEqual(43); // false

         std::cout << x1_res << std::endl;
         std::cout << x2_res << std::endl;
         std::cout << x3_res << std::endl;
         std::cout << x4_res << std::endl;
         std::cout << x5_res << std::endl;
         std::cout << x6_res << std::endl;
         std::cout << x7_res << std::endl;
         std::cout << x8_res << std::endl;
         std::cout << x9_res << std::endl;
         std::cout << x10_res << std::endl;
         std::cout << x11_res << std::endl;
         std::cout << x12_res << std::endl;

         return 0;
     }
 };