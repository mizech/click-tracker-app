import Foundation
import SwiftData

@Model
final class Note {
    var text: String
    var counter: Double
    var unit: String
    let createdAt: Date
    var modifiedAt: Date
    
    init(
        text: String = "",
        counter: Double,
        unit: String
    ) {
        self.text = text
        self.counter = counter
        self.unit = unit
        self.createdAt = Date.now
        self.modifiedAt = Date.now
    }
}
