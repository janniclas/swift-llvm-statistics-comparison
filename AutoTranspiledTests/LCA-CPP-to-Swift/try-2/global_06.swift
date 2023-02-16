
var g = 0

func foo() -> Int {
    g += 1
    return g
}

func main() -> Int {
    g += 1
    let i = foo()
    return 0
}