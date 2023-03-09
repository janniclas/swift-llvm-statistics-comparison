class Drawable { func draw() {} }

class Point: Drawable {
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    var x, y: Double
    override func draw() {
        print("Drawing a point")
    }
}
class Line: Drawable {
    init(x1: Double, y1: Double, x2: Double, y2: Double) {
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
    }
    var x1, y1, x2, y2: Double
    override func draw() {
        print("Drawing a line")
    }
}
@main
struct MyMain {
    static func main() {
        var point = Point(x: 1, y: 2)
        point.draw()
        var line = Line(x1: 1, y1: 2, x2: 3, y2: 4)
        line.draw()
    }
}
