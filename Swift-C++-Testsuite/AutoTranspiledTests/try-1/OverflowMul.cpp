
 #include <iostream>
 
 struct MyMain
 {
   static void main()
   {
     //  This call would crash with a normal mul.
     //  returns -9223372036854775808
     int a = mulWithOverflow(INT_MAX);
   }
 
   // The & sign turns an mul to an mul without overflow
   static int mulWithOverflow(int x)
   {
     int tmp = x &* 2;
     return tmp;
   }
};

int main()
{
  MyMain::main();
  return 0;
}