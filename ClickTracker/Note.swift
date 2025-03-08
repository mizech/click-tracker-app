import Foundation
import SwiftData

@Model
final class Note {
    var text: String
    var counter: Double
    var entityName: String
    let createdAt: Date
    var modifiedAt: Date
    
    init(
        text: String = "",
        counter: Double,
        entityName: String
    ) {
        self.text = text
        self.counter = counter
        self.entityName = entityName
        self.createdAt = Date.now
        self.modifiedAt = Date.now
    }
}
