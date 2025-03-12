import Foundation
import SwiftData

@Model
final class Note {
    var title: String
    var text: String
    var counter: Double
    var step: Double
    var unit: String
    let createdAt: Date
    var modifiedAt: Date
    
    init(
        title: String,
        text: String = "",
        counter: Double,
        step: Double,
        unit: String
    ) {
        self.title = title
        self.text = text
        self.counter = counter
        self.step = step
        self.unit = unit
        self.createdAt = Date.now
        self.modifiedAt = Date.now
    }
}
