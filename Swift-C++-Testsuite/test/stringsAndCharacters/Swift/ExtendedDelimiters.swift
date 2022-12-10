@main
struct MyMain {
    //TODO: there is no direct equivalent in CPP, we just need to check wether a new
    // language construct is generated in the IR.
    static func main() {
        let threeMoreDoubleQuotationMarks = #"""
            Here are three more double quotes: """
            """#
    }
}
