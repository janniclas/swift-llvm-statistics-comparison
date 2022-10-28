@main
struct MyMain {

    static func main() {
        var counter = 0
        for a in 1...10 {
            if a % 4 == 0 {
                break
            }
            counter += 1
        }
    }

}
