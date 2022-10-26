//
//  File.swift
//
//
//  Created by Jan-Niclas Strüwer on 26.10.22.
//

import Foundation

@main
struct MyMain {

    static func main() {
        let c = Counter()
        c.increment()
        c.increment(by: 20)
        c.reset()
        c.increment()
        let currentCount = c.count
    }
}
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
