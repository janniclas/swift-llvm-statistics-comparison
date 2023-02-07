
 #include <iostream>
 
 int main() 
 {
     int counter = 0;
     for(int a = 0; a <= 10; ++a) 
     { 
         if(a % 4 == 0)
         {
             break;
         }
         
         counter++;
     }
 
     return 0;
 }