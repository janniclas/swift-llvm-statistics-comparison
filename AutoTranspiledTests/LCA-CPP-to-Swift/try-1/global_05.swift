
var g = 0

func foo(a: Int) -> Int {
    return a + 1 // C++ `return ++a` is equivalent to `return a + 1` in Swift
}

func main() -> Int {
    g += 1
    let i = foo(a: g + 1)
    return 0
}