// When you get a substring from a string—for example, using
// a subscript or a method like prefix(_:)—the result is an
// instance of Substring, not another string. Substrings in
// Swift have most of the same methods as strings, which
// means you can work with substrings the same way you work
// with strings. However, unlike strings, you use substrings
// for only a short amount of time while performing actions
// on a string. When you’re ready to store the result for a
// longer time, you convert the substring to an instance of String.

// Don’t store substrings longer than you need them to perform a specific
// operation. A substring holds a reference to the entire storage of the
// string it comes from, not just to the portion it presents, even when
// there is no other reference to the original string. Storing substrings
// may, therefore, prolong the lifetime of string data that is no longer
// otherwise accessible, which can appear to be memory leakage.
@main
struct MyMain {

    static func main() {
        let greeting = "Hello, world!"
        let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
        let beginning = greeting[..<index]
        // beginning is "Hello"

        // Convert the result to a String for long-term storage.
        let newString = String(beginning)
    }
}
