@main
struct MyMain {

    static func main() {
        let res = Resolution()
        let explicitValues = Resolution(width: 32, height: 64, max: 3232)
    }
}

struct Resolution {
    var width: UInt32 = 0
    var height: UInt64 = 0
    var max: UInt32 = 0
}
