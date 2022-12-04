## Number Equality (==)
* Use the same code

## Number Not Equal (=!)
* Swift uses icmp and xor 
  * %5 = icmp eq i64 %0, 42, !dbg !102
  * %6 = xor i1 %5, true, !dbg !102
* C++ uses icmp ne

## Number Greater than (>)
* Swift compares x > y in the code as x < y in the IR

## Number Larger or Equal (>=) (Same for Smaller or Equal (<=))
* Same as number not equal --> Swift uses icmp slt and xor, C++ icmp sge
