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

func drawACopy<T: Drawable>(local : T) {
    local.draw()
}

@main
struct MyMain {
    static func main() {
        var point = Point(x: 1, y: 2)
        drawACopy(local: point)
        var line = Line(x1: 1, y1: 2, x2: 3, y2: 4)
        drawACopy(local: line)

    }
}
