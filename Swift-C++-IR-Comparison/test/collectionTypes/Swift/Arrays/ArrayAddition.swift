

@main
struct MyMain {

    static func main() {
        var threeDoubles = Array(repeating: 0.0, count: 3)
        var fourDoubles = [2.0, 1.3, 2.2, 4.2]
        var sevenDoubles = threeDoubles + fourDoubles
    }
}
