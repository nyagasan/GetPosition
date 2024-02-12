import SwiftUI
import RealityKit
import RealityKitContent

struct DragGestureView: View {
    @State var rotation:Rotation3D = Rotation3D()
    
    var rotate:some Gesture {
        RotateGesture3D()
            .targetedToAnyEntity()
            .onChanged { gesture in
                rotation = gesture.rotation
            }
    }
    
    var body: some View {
        RealityView { content in
            let box = ModelEntity(mesh: .generateBox(size: 0.25))
            box.generateCollisionShapes(recursive: false)
            box.components.set(InputTargetComponent())
            content.add(box)
        }
//        .gesture(rotate)
//        .rotation3DEffect(rotation)
        .dragRotation()
    }
}

#Preview {
    DragGestureView()
        .previewLayout(.sizeThatFits)
}
