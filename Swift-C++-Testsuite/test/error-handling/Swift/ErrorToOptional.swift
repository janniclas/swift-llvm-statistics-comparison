@main
struct MyMain {

    static func main() {
        func someThrowingFunction() throws -> Int {
            // ...
            return 42
        }

        let x = try? someThrowingFunction()

        let y: Int?
        do {
            y = try someThrowingFunction()
        } catch {
            y = nil
        }

    }

}
