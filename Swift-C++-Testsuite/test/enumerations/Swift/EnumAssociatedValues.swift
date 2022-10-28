// You can define Swift enumerations to store associated
// values of any given type, and the value types can be
// different for each case of the enumeration if needed.
// Enumerations similar to these are known as discriminated
// unions, tagged unions, or variants in other programming languages.

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
@main
struct MyMain {

    static func main() {

        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        let first = strangeSum(productBarcode)
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        let second = strangeSum(productBarcode)
    }

    static func strangeSum(_ code: Barcode) -> Int {
        var x = 0
        switch code {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            x = numberSystem + manufacturer + product + check
        case .qrCode(let productCode):
            x = -1
        }
        return x
    }
}
