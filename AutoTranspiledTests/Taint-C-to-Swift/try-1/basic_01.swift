
 func foo(A: Int, B: Int) -> Int { return 0 }

 func bar() -> Int { return 0 }
 
 func baz(A:Int, B:Int, C:Int) -> Int { return 0 }
 
 func quark() {}
 
 func average(_ Count: Int, Values: Double...) -> Double {
   var total: Double = 0
   
   for value in Values {
        total += value
   }
  
   return total / Double(Count)
 }

 func main() -> Int {
   let A = foo(A: 42, B: 13)
   let B = bar()
   var C = A + 42
   C = baz(A: C, B: A, C: B)
   quark()
   let avg = average(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
   return C
 }