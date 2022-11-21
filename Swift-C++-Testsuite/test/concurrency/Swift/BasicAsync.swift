@main
struct MyMain {

    static func main() async {
        let photos = await listPhotos(inGallery: "home")
    }

    static func listPhotos(inGallery name: String) async -> [String] {
        let result = ["MyPhotoNames"]  // ... some asynchronous networking code ...
        do {
            try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
        } catch {
            print("Sleep failed")
        }
        return result
    }
}
