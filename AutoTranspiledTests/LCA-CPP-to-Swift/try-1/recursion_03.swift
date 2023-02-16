
func foo(i: UInt) -> UInt {
  if i == 0 {
    return 1
  }
  return foo(i: i - 1)
}

let a = foo(i: 5)