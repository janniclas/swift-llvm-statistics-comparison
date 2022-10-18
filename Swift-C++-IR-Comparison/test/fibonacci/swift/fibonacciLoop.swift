@main
struct Fibonacci {
static func main() {
    let lim = 5
    var a = 0, b = 1
    while b < lim {
	print(b)
	(a, b) = (b, a + b)
    }
}
}
