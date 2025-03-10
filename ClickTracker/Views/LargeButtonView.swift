import SwiftUI

struct LargeButtonView: View {
    @Binding var counter: Double
    
    var caption: String
    var sysImg: String
    var bgColor: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Label(caption, systemImage: sysImg)
                .padding()
                .frame(maxWidth: .infinity)
                .background(bgColor)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .roundedCorners()
        }.padding(.horizontal, 25)
    }
}

#Preview {
    LargeButtonView(
        counter: .constant(1),
        caption: "Caption",
        sysImg: "plus",
        bgColor: .green
    ) {}
}
