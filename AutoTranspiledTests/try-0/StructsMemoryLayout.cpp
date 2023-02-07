 
struct Resolution { 
  UInt32 width = 0;
  UInt64 height = 0;
  UInt32 max = 0;
};

int main() { 
  Resolution res; 
  Resolution explicitValues { 32, 64, 3232 }; 
}