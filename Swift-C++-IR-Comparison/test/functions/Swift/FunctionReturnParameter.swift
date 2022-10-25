@main
struct MyMain {

    static func main() {
        let myRes = identity(x: 42)
    }

}

func identity(x: Int) -> Int {
    return x
}
