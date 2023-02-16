
 #include <iostream>
 #include <map> 
 
 
int main(){
   std::map<int, int> namesOfIntegers; 
   namesOfIntegers.insert({5, 32}); 
   namesOfIntegers.insert({4, 42});  
   namesOfIntegers.erase(4);
  
   return 0; 
}