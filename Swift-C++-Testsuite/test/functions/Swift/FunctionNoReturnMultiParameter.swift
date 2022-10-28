@main
struct MyMain {

    static func main() {
        paramNoReturn(x: 42, t: true)
    }

}

func paramNoReturn(x: Int, t: Bool) {
    if t {
        let a = 5
        let b = 10
        let c = a + b + x
    }
}
