@main
struct MyMain {

    static func main() {
        implicitReturn(identity: 42)
    }

}

func implicitReturn(identity x: Int) -> Int {
    return x
}
