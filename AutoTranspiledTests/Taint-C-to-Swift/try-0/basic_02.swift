

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

func main() {
  var A = X(A: 0, B: 0, C: 0)
  modX(A: &A)
  return A.B
}