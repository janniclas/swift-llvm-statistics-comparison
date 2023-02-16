
var g1 = 1

func foo(a: Int) -> Int {
    a += g1
    return a
}

func bar(b: Int) -> Int {
    g1 += 1
    return b + 1
}

func baz(c: Int) -> Int {
    return c + 3
}

func main() {
    g1 += 1
    var i = 0
    i = foo(a: 10)
    i = bar(b: 3)
    i = baz(c: 39)
    return 0
}