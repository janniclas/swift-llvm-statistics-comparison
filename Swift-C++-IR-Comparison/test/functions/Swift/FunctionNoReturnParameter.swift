@main
struct MyMain {

    static func main() {
        paramNoReturn(x: 42)
    }

}

func paramNoReturn(x: Int) {
    let a = 5
    let b = 10
    let c = a+b+x
}
