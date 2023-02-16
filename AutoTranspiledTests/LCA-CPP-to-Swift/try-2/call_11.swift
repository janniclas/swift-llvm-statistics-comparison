
func bar(b: Int) -> Int {
    return b
}

func foo(a: Int) -> Int {
    return bar(b: a)
}

func main() {
    var i: Int 
    i = foo(a: 2)
    return
}