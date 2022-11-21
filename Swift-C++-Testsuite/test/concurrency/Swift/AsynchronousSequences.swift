import Foundation

@main
struct MyMain {

    static func main() async throws {
        let handle = FileHandle.standardInput
        for try await line in handle.bytes.lines {
            print(line)
        }
    }
}
