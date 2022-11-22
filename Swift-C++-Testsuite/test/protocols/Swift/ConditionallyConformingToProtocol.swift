@main
struct MyMain {

    static func main() {
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        let myDice = [d6, d12]
        print(myDice.textualDescription)
    }

}
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
protocol TextRepresentable {
    var textualDescription: String { get }
}
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
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
