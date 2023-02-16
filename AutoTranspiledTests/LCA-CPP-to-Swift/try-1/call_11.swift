
 func bar(b: Int) -> Int { // clang-format off
     return b
 }

 func foo(a: Int) -> Int {
    return bar(b: a)
 } // clang-format on

 func main() {
    var i: Int
    i = foo(a: 2)
    return 0
}