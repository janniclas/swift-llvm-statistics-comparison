@main
struct MyMain {

    static func main() {
        let vm = VideoMode()
        let res = Resolution()
        let fr = vm.frameRate
        let px = res.height * res.width

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
