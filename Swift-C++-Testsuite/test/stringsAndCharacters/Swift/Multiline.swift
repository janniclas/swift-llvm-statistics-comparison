@main
struct MyMain {

    static func main() {
        // When your source code includes a line break inside of a multiline
        // string literal, that line break also appears in the string’s value.
        // If you want to use line breaks to make your source code easier to
        // read, but you don’t want the line breaks to be part of the string’s
        // value, write a backslash (\) at the end of those lines:
        var vogon_poem = """
            V0G0N(
                            O freddled gruntbuggly thy micturations are to me
                                As plured gabbleblochits on a lurgid bee.
                            Groop, I implore thee my foonting turlingdromes.   
                        And hooptiously drangle me with crinkly bindlewurdles,
                Or I will rend thee in the gobberwarts with my blurlecruncheon, see if I don't.

                                (by Prostetnic Vogon Jeltz; see p. 56/57)
                )V0G0N
            """
    }
}
