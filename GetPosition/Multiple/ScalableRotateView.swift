import SwiftUI
import RealityKit
import RealityKitContent

struct ScalableRotateView: View {
    
    @State private var magnifyBy = 1.0 // 現在のスケール
    @State private var initialMagnifyBy = 1.0 // ジェスチャー開始時のスケール
    @State var earthEntity: ModelEntity = ModelEntity()
    
    var body: some View {
        RealityView { content in
            if let entity = try? await ModelEntity(named: "Neptune.usdz") {
                content.add(entity)
                entity.scale = [1,1,1]
                let bounds = entity.model!.mesh.bounds.extents
                entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
                entity.components.set(InputTargetComponent())
                earthEntity = entity
            }
        } update: { content in
            if let entity = content.entities.first {
                let uniformScale: Float = Float(magnifyBy)
                entity.transform.scale = [uniformScale, uniformScale, uniformScale]
            }
        }
        .gesture(magnification)
        .dragRotation(
            pitchLimit: .degrees(90)
        )
        .scaleEffect(magnifyBy)
        
        
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
    ScalableRotateView()
}
