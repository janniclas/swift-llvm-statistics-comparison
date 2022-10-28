// String interpolation is a way to construct a new String value from
//  a mix of constants, variables, literals, and expressions by including
//  their values inside a string literal. You can use string interpolation
//  in both single-line and multiline string literals. Each item that you
//  insert into the string literal is wrapped in a pair of parentheses,
//  prefixed by a backslash (\):

@main
struct MyMain {

    static func main() {
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        // message is "3 times 2.5 is 7.5"
    }
}
