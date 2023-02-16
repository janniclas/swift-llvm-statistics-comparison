

func foo() {}

func foo(_ A: Int) {}

func foo(_ A: Int, _ B: Int) {}

func foo(_ A: Int, _ B: Int, _ C: Int) {}

func foo(_ A: Int, _ B: Int, _ C: Int, _ D: Int) {}

func main() {
    foo()
    foo(1)
    foo(1, 2)
    foo(1, 2, 3)
    foo(1, 2, 3, 4)
}

main()