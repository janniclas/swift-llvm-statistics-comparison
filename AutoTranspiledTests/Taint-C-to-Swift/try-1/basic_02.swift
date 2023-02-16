

struct X {
  var A: Int
  var B: Int
  var C: Double
}

func modX(var A: X){
  A.A = 42
  A.B = 13
  A.C = 1.23
}

func main() -> Int {
  var A = X(A:0, B:0, C:0.0)
  modX(&A)
  return A.B
}