import SwiftUI
import RealityKit

struct AttachmentLabelView: View {
    @State var textModelList: [TextModel] = []
    @State var earthEntity: ModelEntity = ModelEntity()
    @State var count: Int = 0
    
    var body: some View {
        RealityView { content, attachments in
            if let entity = try? await ModelEntity(named: "Earth.usdz") {
                content.add(entity)
                entity.scale = [1,1,1]
                let bounds = entity.model!.mesh.bounds.extents
                let visualBoundsSize = entity.visualBounds(relativeTo: nil).size
                let targetSize: Float = 0.6
                let scale = targetSize / visualBoundsSize.x // ここでは幅を基準にしている
                entity.scale = SIMD3<Float>(repeating: scale)
                entity.collision = try? await CollisionComponent(shapes: [ShapeResource.generateConvex(from: entity.model!.mesh)])
                entity.components.set(InputTargetComponent())
                earthEntity = entity
            }
        } update: { content, attachments in
            for textModel in textModelList {
                if let text = attachments.entity(for: textModel.id) {
                    content.add(text)
                    text.look(at: .zero, from: textModel.location, relativeTo: text.parent)
                }
            }
        } attachments: {
            ForEach(textModelList) { textModel in
                Attachment(id: textModel.id) {
//                    VStack {
//                        Image(systemName: "visionpro")
//                            .imageScale(.large)
//                        Text(textModel.text)
//                            .font(.system(size: 32.0))
//                            .bold()
//                        Text("Vision Pro Challenge")
//                    }
//                    .padding(.all, 15)
//                    .glassBackgroundEffect()
                    LearnMoreView(name: textModel.text,
                                  description: textModel.descreption,
                                  imageNames: [""],
                                  trail: nil
                                  )
                }
            }
        }.gesture(
            SpatialTapGesture()
                .targetedToEntity(earthEntity)
                .onEnded { value in
                    let location = value.location3D
                    let convertedLocation = 1.05 * value.convert(location, from: .local, to: .scene)
                    textModelList.append(TextModel(text: "Earth:\(count)",location: convertedLocation))
                    count = count + 1
            }
        )
        .dragRotation(
            pitchLimit: .degrees(90)
        )
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
            }
    }
}

#Preview() {
    AttachmentLabelView()
    
}
