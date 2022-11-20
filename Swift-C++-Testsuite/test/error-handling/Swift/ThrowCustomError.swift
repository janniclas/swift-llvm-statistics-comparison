@main
struct MyMain {
    enum VendingMachineError: Error {
        case invalidSelection
        case insufficientFunds(coinsNeeded: Int)
        case outOfStock
    }
    static func main() {
        do {
            try vendingMachineInteraction()
        } catch {
            let e = error
        }

    }

    static func vendingMachineInteraction() throws {
        throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
    }
}
