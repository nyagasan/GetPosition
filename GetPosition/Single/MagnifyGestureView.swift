import SwiftUI
import RealityKit
import RealityKitContent

struct MagnifyGestureView: View {
    
    @State private var magnifyBy = 1.0 // 現在のスケール
    @State private var initialMagnifyBy = 1.0 // ジェスチャー開始時のスケール
    
    var body: some View {
        RealityView { content in
            if let entity = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(entity)
            }
        } update: { content in
            if let entity = content.entities.first {
                let uniformScale: Float = Float(magnifyBy)
                entity.transform.scale = [uniformScale, uniformScale, uniformScale]
            }
        }
        .scaleEffect(magnifyBy)
        .gesture(magnification)
    }
    
    var magnification: some Gesture {
        MagnifyGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                magnifyBy = initialMagnifyBy * value.magnification
            }
            .onEnded { _ in
                initialMagnifyBy = magnifyBy
            }
    }
}

#Preview {
    MagnifyGestureView()
}
