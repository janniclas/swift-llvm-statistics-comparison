protocol Drawable { func draw() }

struct Point: Drawable {
    var x, y: Double
    func draw() {
        print("Drawing a point")
    }
}
struct Line: Drawable {
    var x1, y1, x2, y2: Double
    func draw() {
        print("Drawing a line")
    }
}
@main
struct MyMain {
    static func main() {
        var drawables: [Drawable] = []
        drawables.append(Point(x: 1, y: 2))
        drawables.append(Line(x1: 1, y1: 2, x2: 3, y2: 4))
        for d in drawables {
            d.draw()
        }
    }
}
