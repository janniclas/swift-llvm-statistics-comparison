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
        let somePoint = Point(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOf(x: 1.0) {
            let something = 42
        }
    }
}
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
