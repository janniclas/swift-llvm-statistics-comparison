// If a property marked with the lazy modifier is accessed by
// multiple threads simultaneously and the property hasn’t yet
// been initialized, there’s no guarantee that the property
// will be initialized only once.

@main
struct MyMain {

    static func main() {
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")

        let retriveLazyVar = manager.importer.filename
    }
}

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}
