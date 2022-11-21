@main
struct MyMain {

    static func main() {
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
    }

}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom =
            ((lastRandom * a + c)
                .truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

protocol RandomNumberGenerator {
    func random() -> Double
}
