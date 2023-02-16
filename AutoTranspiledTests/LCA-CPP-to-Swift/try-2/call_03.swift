
func foo() -> Int { // clang-format off
    return 42
} // clang-format on
 
func main() {
    let i = foo()
    return 0
}