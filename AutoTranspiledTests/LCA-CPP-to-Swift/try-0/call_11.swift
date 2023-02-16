
func bar(b: Int) -> Int {
    return b
}

func foo(a: Int) -> Int {
    return bar(b: a)
}

func main() -> Int {
    var i = 0
    i = foo(a: 2)
    return 0
}