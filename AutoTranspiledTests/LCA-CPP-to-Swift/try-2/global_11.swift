
var g1 = 42
var g2 = 9001

func foo(x: Int) -> Int {
    x += 1 
    return x
}

func main() -> Int {
    var a = 13
    a = foo(x: a)
    return a
}