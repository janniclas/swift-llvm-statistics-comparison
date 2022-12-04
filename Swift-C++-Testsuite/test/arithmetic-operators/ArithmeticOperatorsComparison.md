# Arithmetic Operators Differences

## General Differences
Swift and C++ have different behavior in regards of overflow of arithmetic operations. 
Swift's operations don't overflow by default.

## Addition
* Usage of intrinsic add.with.overflow method
* Additional break in control flow due to check of overflow
* Extractelement to get the result of the addition

## Unary Operations
* Behave identical (+x is a no-op, -x inverts the value)
* For -x C++ and Swift both substract the value from 0. Swift uses the ssub.with.overflow function and C++ the sub nsw operator

## Division
* Both use sdiv as operator
* Swift has multiple additional instructions
  * icmp to check the size of the operand for overflows
    * %6 = icmp eq i64 %0, -9223372036854775808
  * 2 phi nodes to check the result of icmp depending on the chosen bb
    * %10 = phi i1 [ false, %8 ], [ false, %7 ]
    * %11 = phi i64 [ %0, %8 ], [ %0, %7 ] (this one is only there for compound operations TODO: check why)


## Multiplication and Substraction
* Equivalent to Addition
## Reminder
* Both use srem for the actual calculation of the reminder
* Swift does additional checks in regards of overflows --> for x % y it checks %9 = icmp eq i64 x, -9223372036854775808
