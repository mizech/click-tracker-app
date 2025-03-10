import Foundation
import SwiftUI

struct RoundedCorners: ViewModifier {
    func body(content: Content) -> some View {
        return content.clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func roundedCorners() -> some View {
        modifier(RoundedCorners())
    }
}
