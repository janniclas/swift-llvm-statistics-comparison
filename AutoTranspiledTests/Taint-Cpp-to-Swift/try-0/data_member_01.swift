 

struct X {
  var A = 13
  var B = 0
}

func main() -> Int {
    var V = X()
    V.B = 42
    return V.A + V.B
}