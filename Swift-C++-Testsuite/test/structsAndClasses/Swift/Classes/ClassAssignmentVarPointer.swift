//TODO: Learning - it makes a huge difference in the generated IR, wether
// the pointer 'copied' is defined as a let constant or a variable!

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
