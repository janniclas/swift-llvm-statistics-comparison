@main
struct MyMain {

    static func main() {
        var counter = 0
        var max = 7
        if counter < max {
            counter += 1
        } else if counter == max {
            counter = -1
        }
    }
}
