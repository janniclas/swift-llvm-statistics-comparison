@_silgen_name("sink")
func sink(_ p: [String])

@main
struct MyMain {
    static func main() {
        sink(CommandLine.arguments)
    }
}
