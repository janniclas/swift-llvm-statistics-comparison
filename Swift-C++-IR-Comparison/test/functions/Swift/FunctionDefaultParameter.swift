@main
struct MyMain {

    static func main() {
        let withExplicitValue = defaultParameter(x: 44)
        let withDefault = defaultParameter()
    }

}

func defaultParameter(x: Int = 42) -> Int {
    return x + 2
}
