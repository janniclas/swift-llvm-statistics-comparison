@main
struct MyMain {

    static func main() {
        let someVehicle = Vehicle()
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        let des = automatic.description
    }
}
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

//If you provide a setter as part of a property override, you must also
//provide a getter for that override. If you don’t want to modify
//the inherited property’s value within the overriding getter, you
//can simply pass through the inherited value by returning
//super.someProperty from the getter, where someProperty is the name
//of the property you are overriding.
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
