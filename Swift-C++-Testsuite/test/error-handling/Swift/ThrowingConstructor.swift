struct S {
    var data: Int
    init(_ data: Int) throws {
        self.data = data
    }
}
@main
struct MyMain {
    static func main() {
        do {
            var s = try S(0)
        } catch {

        }
    }
}
