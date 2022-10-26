// If a property marked with the lazy modifier is accessed by
// multiple threads simultaneously and the property hasn’t yet
// been initialized, there’s no guarantee that the property
// will be initialized only once.

@main
struct MyMain {

    static func main() {
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        let computeMe = fourByFiveByTwo.volume
    }
}
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
