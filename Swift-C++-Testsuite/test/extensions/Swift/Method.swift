@main
struct MyMain {

    static func main() {
        3.repetitions {
            print("Hello!")
        }
    }
}

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
