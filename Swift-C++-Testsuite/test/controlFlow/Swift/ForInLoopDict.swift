@main
struct MyMain {

    static func main() {
        var a = [1: 2, 2: 3, 3: 4, 4: 5, 5: 6]
        var sum = 0
        for (b, c) in a {
            sum = sum + b + c
        }
    }
}
