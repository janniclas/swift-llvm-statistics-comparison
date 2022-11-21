@main
struct MyMain {

    static func main() async {
        let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
        let maxTemp = await logger.max
    }

}

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
