
 #include <iostream>
 
 struct MyMain { 
     static void main(){ 
         int counter = 0; 
 #ifdef __APPLE__ 
         #if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101200 
             counter = 42; 
         #else
             counter = 44; 
         #endif 
 #elif defined(__linux__) 
 #elif defined(_WIN32) 
 #endif 
      } 
 }; 
 
 int main(){ 
     MyMain::main(); 
     return 0; 
 }