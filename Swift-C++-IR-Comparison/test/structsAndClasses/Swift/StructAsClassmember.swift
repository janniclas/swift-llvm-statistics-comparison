@main
struct MyMain {

    static func main() {
        let vm = VideoMode()
    }
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

struct Resolution {
    var width = 0
    var height = 0
}
