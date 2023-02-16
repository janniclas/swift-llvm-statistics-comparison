
 var g = 0
 
 func global_ctor() {
    g = 42
 }
 
 func global_dtor() {
    g = 666
 }
 
 func foo(x: Int) -> Int {
    x + 1
 }
 
 func main() -> Int {
    let a = g
    let b = foo(x: a)
    return g
 }