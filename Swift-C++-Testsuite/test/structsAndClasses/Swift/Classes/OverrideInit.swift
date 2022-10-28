@main
struct MyMain {

    static func main() {
        let bicycle = Bicycle()
        let hoverboard = Hoverboard(color: "silver")
        let hovDes = hoverboard.description
        let biDes = bicycle.description
    }
}

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
