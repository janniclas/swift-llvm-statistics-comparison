

struct X {
  var A: Int
  var B: Int
  var C: Double
}

func modX(A: inout X) {
  A.A = 42
  A.B = 13
  A.C = 1.23
}

func main() -> Int {
  var A = X()
  modX(A: &A)
  return A.B
}