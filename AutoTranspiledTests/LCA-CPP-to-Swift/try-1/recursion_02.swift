
func fac(i: Int) -> Int {
  if i == 0 {
    return 1
  }
  
  return i * fac(i - 1)
}

let a = fac(5)