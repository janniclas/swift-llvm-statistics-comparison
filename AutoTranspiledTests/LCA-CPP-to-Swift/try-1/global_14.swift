
 var g = 0
 struct X {
 	init() {
 		g = 1024
 	}
 }
 
 func foo(_ x: Int) -> Int {
 	x = x + 1
 	return x
 }
 let var = X()
 
 func main() -> Int  {
 	var a = g
 	a = foo(a)
 	return a
 }