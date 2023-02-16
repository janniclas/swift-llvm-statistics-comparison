 
 var g1 = 1
 
 func foo(_ a: Int) -> Int {
     a += g1
     return a
 }
 
 func bar(_ b: Int) -> Int {
     g1 += 1
     return b + 1
 }
 
 func baz(_ c: Int) -> Int {
     return c + 3
 }
 
 func main() -> Int {
     g1 += 1
     var i = 0
     i = foo(10)
     i = bar(3)
     i = baz(39)
     return 0
 }