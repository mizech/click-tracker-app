import Foundation
import SwiftData

@Model
final class Note {
    var text: String
    var counter: Double
    var step: Double
    var unit: String
    let createdAt: Date
    var modifiedAt: Date
    
    init(
        text: String = "",
        counter: Double,
        step: Double,
        unit: String
    ) {
        self.text = text
        self.counter = counter
        self.step = step
        self.unit = unit
        self.createdAt = Date.now
        self.modifiedAt = Date.now
    }
}
