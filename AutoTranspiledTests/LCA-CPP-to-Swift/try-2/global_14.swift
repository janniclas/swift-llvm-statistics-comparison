 
var g = 0

struct X {
   init() {
      g = 1024
   }
}

func foo(x: Int) -> Int {
   x += 1
   return x
}

var var = X()

func main() -> Int {
   var a = g
   a = foo(x: a)
   return a
}

main()