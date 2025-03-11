import SwiftUI

struct CountButtonView: View {
    @Binding var counter: Double
    
    var caption: String
    var sysImg: String
    var bgColor: Color
    var action: () -> Void
    
    var body: some View {
        LargeButtonView(caption: caption, sysImg: sysImg, bgColor: bgColor, action: action)
    }
}

#Preview {
    CountButtonView(
        counter: .constant(8),
        caption: "Increment",
        sysImg: "gear",
        bgColor: .blue,
        action: {
        })
}
