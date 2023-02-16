

func foo() {}

func foo(A: Int) {}

func foo(A: Int, B: Int) {}

func foo(A: Int, B: Int, C: Int) {}

func foo(A: Int, B: Int, C: Int, D: Int) {}

func main() {
  foo()
  foo(A: 1)
  foo(A: 1, B: 2)
  foo(A: 1, B: 2, C: 3)
  foo(A: 1, B: 2, C: 3, D:4)
}

main()