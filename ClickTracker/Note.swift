import Foundation
import SwiftData

@Model
final class Note {
    var text: String
    let createdAt: Date
    var modifiedAt: Date
    
    init(text: String = "") {
        self.text = text
        self.createdAt = Date.now
        self.modifiedAt = Date.now
    }
}
