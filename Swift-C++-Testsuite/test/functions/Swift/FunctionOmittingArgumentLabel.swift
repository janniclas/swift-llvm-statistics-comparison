@main
struct MyMain {

    static func main() {
        implicitReturn(42)
    }

}

func implicitReturn(_ x: Int) -> Int {
    return x
}
