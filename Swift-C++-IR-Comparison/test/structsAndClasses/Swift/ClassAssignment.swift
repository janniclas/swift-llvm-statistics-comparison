@main
struct MyMain {

    static func main() {
        let vm = VideoMode()
        var copied = vm
        copied.interlaced = true
        copied.frameRate = 2.7
    }
}
class VideoMode {
    var interlaced = false
    var frameRate = 0.0
    var name: String = "My Mode"
}
