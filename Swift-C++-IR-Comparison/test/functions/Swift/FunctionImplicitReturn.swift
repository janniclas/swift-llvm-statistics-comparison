@main
struct MyMain {

    static func main() {
        implicitReturn(x: 42)
    }

}

func implicitReturn(x: Int) -> Int {
    x + 2
}
