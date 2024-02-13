import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        AttachmentOrbitView()
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
