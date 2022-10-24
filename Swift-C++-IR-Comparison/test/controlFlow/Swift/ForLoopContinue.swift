@main
struct MyMain {

    static func main() {
        var counter = 0
        for a in 0...10 {
            if a % 2 == 0 {
                continue
            }
            counter += 1
        }
    }

}
