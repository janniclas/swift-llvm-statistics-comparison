@main
struct MyMain {

    static func main() {
        let john = Person()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        john.residence = Residence()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
    }
}

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}
