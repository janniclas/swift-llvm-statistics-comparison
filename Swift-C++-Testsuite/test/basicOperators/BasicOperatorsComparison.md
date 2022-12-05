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


## String Comparison
* Swift compares strings with custom functions e.g.:
  * %10 = call swiftcc i1 @"static Swift.String.< infix(Swift.String, Swift.String) -> Swift.Bool"(i64 %0, %swift.bridge* %1, i64 %8, %swift.bridge* %9)
  * The IR only contains the function declaration no implementation details.
* C++ compares strings with custom function, however they generate the code for the comparison into the IR.

## Tuple Comparison
* Comparable to Strings
* Swift uses a generic function, with a protocol enforcing both elements of the tuple to be comparable/equatable
* C++ compares tuples with custom function, however they generate the code for the comparison into the IR.