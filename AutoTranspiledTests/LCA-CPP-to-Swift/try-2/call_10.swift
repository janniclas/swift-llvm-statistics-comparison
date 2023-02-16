
func bar(b: Int) {

}

func foo(a: Int) { // clang-format off
    bar(b: a)
} // clang-format on

func main() {
    var i: Int
    foo(a: 2)
    return 0
}