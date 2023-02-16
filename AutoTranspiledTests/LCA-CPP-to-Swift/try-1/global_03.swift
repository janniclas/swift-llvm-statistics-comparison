
 var g = 0
 
 func foo() { // clang-format off
    g += 1
 } // clang-format on
 
 func main() -> Int {
    let i = 42
    g += 1
    foo()
    return 0
 }