@main
struct MyMain {

    static func main() {
        let myRes = identity(x: 42)
    }
    static func identity(x: Int, t: Bool)-> Int {
        if(t) {
            return x
        } else {
            return -x
        }
    }

}
