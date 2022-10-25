enum CompassPoint {
    case north
    case south
    case east
    case west
}
@main
struct MyMain {

    static func main() {

        let first = wayfinder(direction: CompassPoint.east)
        let second = wayfinder(direction: CompassPoint.north)

    }

    static func wayfinder(direction: CompassPoint) -> Int {
        var x = 0
        switch direction {
        case .north:
            x += 1
        case .south:
            x += 2
        case .east:
            x += 3
        case .west:
            x += 412
        }
        return x
    }
}
