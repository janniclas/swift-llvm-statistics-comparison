@main
struct MyMain {

    static func main() {
        let res = Resolution(width: 1920, height: 1080)
        let s = toString(res)
    }
}

func toString(_ res: Resolution) -> String {
    let width = String(res.width)
    let height = String(res.height)
    return "The resolution is \(width)x\(height)"
}

struct Resolution {
    var width = 0
    var height = 0
}
