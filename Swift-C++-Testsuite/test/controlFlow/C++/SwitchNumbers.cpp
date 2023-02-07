
   
   static int switchMe(int input) {
       int counter = 0;
       int max = 7;
       
       switch(input) {
           case 1:
               counter = max;
               break;
           case 0:
               counter = -max;
               break;
           default:
               counter = 42;
       }
       return counter;
   }


 int main() {
       int res = switchMe(1);
       return 0;
   }
