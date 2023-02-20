## General
* Swift oftentimes hides the method implementation. This means more upfront work to model the method's behavior in the analysis, however we don't have to analyse the method itself, so it's more busy work. 
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

## Assignments
* In Swift an Integer is defined as a struct, thus the access is done with a getElementPtr instruction

## Globals
* @g = dso_local global i32 10, align 4, !dbg !0 in C++  
define hidden swiftcc i8* @"$s9global_031gSivau"() #0 !dbg !36 {
entry:
  ret i8* bitcast (%TSi* @"$s9global_031gSivp" to i8*), !dbg !40
}
@"$s9global_012g1Sivp" = hidden global %TSi <{ i64 10 }>, align 8, !dbg !0
@"$s9global_012g2_Wz" = internal global i64 0, align 8
@"$s9global_012g2Sivp" = hidden global %TSi <{ i64 1 }>, align 8, !dbg !8
@"$s9global_012g3_Wz" = internal global i64 0, align 8
@"$s9global_012g3Sdvp" = hidden global %TSd <{ double 3.141500e+00 }>, align 8, !dbg !10