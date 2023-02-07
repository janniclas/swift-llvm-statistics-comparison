
int switchMe(int x, int y) {
  int counter = 0;
  int max = 7;
  switch(x, y) {
   case (1, 1): 
    counter = max;
    break;
    case (0, 1):
    counter = -max;
    break;
   case (0, _):
    counter = -max;
    break;
   default:
    counter = 42;
    break;
   }
  return counter;
}

int main() {
 int res = switchMe(2, 3);
 return 0;
}