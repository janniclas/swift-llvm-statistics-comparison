 
func foo(x: Int) -> Int {
    return x + 1
}

func main() -> Int {
    var i = 42
    i = foo(x: i)
    return i
}