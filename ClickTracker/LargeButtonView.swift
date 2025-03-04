import SwiftUI

struct LargeButtonView: View {
    var caption: String
    var sysImg: String
    var bgColor: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            
        } label: {
            Label(caption, systemImage: sysImg)
                .padding()
                .frame(maxWidth: .infinity)
                .background(bgColor)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }.padding(.horizontal, 25)
    }
}

#Preview {
    LargeButtonView(caption: "Caption", sysImg: "plus", bgColor: .green) {}
}
