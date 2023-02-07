
 #include <iostream>
 #include <random>
 
 int magical(int z)
 {
     int a = 78092178;
     int b = 45124;
     int x = a + b;
     return x + z;
 }
 
 int main()
 {
     std::uniform_int_distribution <int> rand(1, 100);
 
     int rand_num = rand(rng);
 
     int myResult = -1;
     if (rand_num < 40)
     {
         myResult = magical(rand_num);
         // 78149714
     }
     else
     {
         myResult = magical(12411);
         // 78149713
     }
     return 0;
 }