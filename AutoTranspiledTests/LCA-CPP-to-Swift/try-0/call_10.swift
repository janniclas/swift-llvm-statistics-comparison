
func bar(b: Int) { }

func foo(a: Int) { // clang-format off
bar(a: a)
} // clang-format on

func main() {
    let i: Int
    foo(a: 2)
    return 0
}