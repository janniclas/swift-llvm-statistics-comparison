@main
struct MyMain {

    static func main() {
        let myNil = identity(x: 42)
        let myIdentity = identity(x: 0)
    }
    static func identity(x: Int) -> Int? {
        if x == 0 {
            return x
        }
        return nil
    }
}
