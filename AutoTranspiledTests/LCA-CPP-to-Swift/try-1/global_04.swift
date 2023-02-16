
var g = 0

func foo(a: Int) -> Int {
    return a + 1
}

func main() -> Int {
    g += 1
    let i = foo(a: g)
    return 0
}