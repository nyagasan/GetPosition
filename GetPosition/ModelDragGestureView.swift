import SwiftUI
import RealityKit
import RealityKitContent

struct ModelDragGestureView: View {
    @State var rotation:Rotation3D = Rotation3D()
    @State var earthEntity: ModelEntity = ModelEntity()
    
    var rotate:some Gesture {
        RotateGesture3D()
            .targetedToAnyEntity()
            .onChanged { gesture in
                rotation = gesture.rotation
            }
    }
    
    var body: some View {
        RealityView { content in
            if let entity = try? await ModelEntity(named: "Earth") {
                entity.scale = [1,1,1]
                let bounds = entity.model!.mesh.bounds.extents
                let visualBoundsSize = entity.visualBounds(relativeTo: nil).size
                let targetSize: Float = 0.6
                let scale = targetSize / visualBoundsSize.x
                entity.scale = SIMD3<Float>(repeating: scale)
                entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
                entity.components.set(InputTargetComponent())
                content.add(entity)
            }
        }
        .gesture(rotate)
        .rotation3DEffect(rotation)
    }
}

#Preview {
    ModelDragGestureView()
        .previewLayout(.sizeThatFits)
}
