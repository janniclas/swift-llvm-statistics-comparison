
struct X {
  var A: Int = 13
  var B: Int = 0
}

func main() -> Int {
  var V = X()
  V.B = 42
  return V.A + V.B
}