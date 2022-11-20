@main
struct MyMain {

    static func main() {
        try? processFile(filename: "testfile.txt")
    }
    static func processFile(filename: String) throws {
        if exists(filename) {
            let file = open(filename)
            defer {
                close(file)
            }
            while let line = try file.readline() {
                // Work with the file.
            }
            // close(file) is called here, at the end of the scope.
        }
    }
    static func exists(_ fName: String) -> Bool {
        return true
    }
    static func open(_ fName: String) -> File {
        return File(name: fName)
    }
    static func close(_ file: File) -> String {
        return "closed"
    }
}

struct File {
    let name: String

    func readline() throws -> String? {
        return "test"
    }
}
