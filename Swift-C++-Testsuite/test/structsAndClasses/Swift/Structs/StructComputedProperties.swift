// If a property marked with the lazy modifier is accessed by
// multiple threads simultaneously and the property hasn’t yet
// been initialized, there’s no guarantee that the property
// will be initialized only once.

@main
struct MyMain {

    static func main() {
        var square = Rect(
            origin: Point(x: 0.0, y: 0.0),
            size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        // initialSquareCenter is at (5.0, 5.0)
        square.center = Point(x: 15.0, y: 15.0)
    }
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
