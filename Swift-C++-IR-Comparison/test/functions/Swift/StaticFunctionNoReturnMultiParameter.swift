@main
struct MyMain {

    static func main() {
        paramNoReturn(x: 42, y: 44)
    }

    static func paramNoReturn(x: Int, y: Int) {
        let a = 5
        let b = 10
        let c = a+b+x+y
    }
}

