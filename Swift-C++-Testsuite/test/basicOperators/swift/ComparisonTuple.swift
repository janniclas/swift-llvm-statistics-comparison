@main
struct MyMain {

    static func main() {
        var a = (41, "zebra") < (42, "apple")  // true because 1 is less than 2; "zebra" and "apple" aren't compared
        var b = (3, "apple") < (3, "bird")  // true because 3 is equal to 3, and "apple" is less than "bird"
        var c = (4, "dog") == (4, "dog")  // true because 4 is equal to 4, and "dog" is equal to "dog"
    }

}
