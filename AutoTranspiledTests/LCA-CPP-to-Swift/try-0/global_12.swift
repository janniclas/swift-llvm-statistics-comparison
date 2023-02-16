
var g = 0

init() {
	g = 42;
}


func foo(x: Int) -> Int {
	x+=1
	return x
}

func main() -> Int{
	var a = g
	a = foo(x: a)
	return a
}