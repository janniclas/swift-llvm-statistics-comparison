@main
struct MyMain {

    static func main() async {
        async let firstPhoto = listPhotos(inGallery: "first")
        async let secondPhoto = listPhotos(inGallery: "second")
        async let thirdPhoto = listPhotos(inGallery: "third")

        let photos = await [firstPhoto, secondPhoto, thirdPhoto]
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
