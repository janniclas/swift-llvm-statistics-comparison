
 var g = 0
 
 func foo(a: Int) -> Int { // clang-format off
     return a + 1
 } // clang-format on
 
 func main() -> Int {
     g += 1
     let i = foo(a: g)
     return 0
 }