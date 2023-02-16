
 var g1 = 42
 var g2 = 9001
 
 func foo(_ x: Int) -> Int {
     x = x + 1
     return x
 }
 
 func main() -> Int {
     var a = 13
     a = foo(a)
     return a
 }