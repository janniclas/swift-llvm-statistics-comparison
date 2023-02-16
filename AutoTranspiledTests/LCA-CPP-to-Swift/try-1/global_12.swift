
 var g = 0
 
 func global_ctor() {
     g = 42
 }
 
 func foo(x: Int) -> Int {
     x = x + 1 
     return x
 }
 
 func main() -> Int {
     var a = g
     a = foo(x: a)
     return a
 }