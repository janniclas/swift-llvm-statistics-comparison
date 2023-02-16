
var cond: Bool = false
func decrement(_ i: Int) -> Int {
  if cond {
    return decrement(i - 1)
  }
  return -1
}

func main() -> Int {
  let j = decrement(-42)
  return 0
}