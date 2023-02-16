
func bar(b: Int) {}

func foo(a: Int) {
    bar(b: a)
}

func main() {
    var i: Int
    foo(a: 2)
    return 0
}