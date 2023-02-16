
var g = 0

func foo(a: Int) -> Int{
a += g
return a
}

func bar(b: Int) -> Int {
g += 1
return b + 1
}

func main() -> Int {
g += 1
var i = 0
i = foo(10)
i = bar(3)
return 0
}