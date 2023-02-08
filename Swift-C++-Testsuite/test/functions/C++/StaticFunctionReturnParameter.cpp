
 
struct MyMain { 
  
    static int identity(int x) 
    { 
        return x; 
    } 
}; 
  

int main() 
{ 
    int myRes = MyMain::identity(42); 
}