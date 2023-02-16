
func foo(a: Int, b: Int) -> Int { // clang-format off
    return a + b
} // clang-format on

func main() -> Int {
    let i = 10
    let j = 1
    let k = foo(a: i, b: j)
    return 0
}