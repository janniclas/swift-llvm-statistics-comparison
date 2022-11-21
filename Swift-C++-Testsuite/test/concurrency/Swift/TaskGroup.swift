@main
struct MyMain {

    static func main() async {
        await withTaskGroup(of: [String].self) { taskGroup in
            let photoNames = await listPhotos(inGallery: "Summer Vacation")
            for name in photoNames {
                taskGroup.addTask { await downloadPhoto(named: name) }
            }
        }
    }
    static func downloadPhoto(named name: String) async -> [String] {
        let result = ["MyPhoto"]  // ... some asynchronous networking code ...
        do {
            try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
        } catch {
            print("Sleep failed")
        }
        return result
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
