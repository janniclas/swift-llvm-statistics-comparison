@main
struct MyMain {

  static func main() {
    // When your source code includes a line break inside of a multiline
    // string literal, that line break also appears in the string’s value.
    // If you want to use line breaks to make your source code easier to
    // read, but you don’t want the line breaks to be part of the string’s
    // value, write a backslash (\) at the end of those lines:
    let softWrappedQuotation = """
      The White Rabbit put on his spectacles.  "Where shall I begin, \
      please your Majesty?" he asked.

      "Begin at the beginning," the King said gravely, "and go on \
      till you come to the end; then stop."
      """

    let lineBreaks = """

      This string starts with a line break.
      It also ends with a line break.

      """
  }
}
