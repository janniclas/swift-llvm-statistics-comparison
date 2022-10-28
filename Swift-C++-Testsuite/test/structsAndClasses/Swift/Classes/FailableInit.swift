@main
struct MyMain {

    static func main() {
        let someCreature = Animal(species: "Giraffe")
        // someCreature is of type Animal?, not Animal

        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }

        let anonymousCreature = Animal(species: "")
        // anonymousCreature is of type Animal?, not Animal

        if anonymousCreature == nil {
            print("The anonymous creature couldn't be initialized")
        }
    }
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
