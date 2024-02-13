import SwiftUI
import RealityKit

struct AttachmentOrbitView: View {
    @State var textModelList: [TextModel] = []
    @State var earthEntity: ModelEntity = ModelEntity()
    @State var count: Int = 0
    
    var body: some View {
        RealityView { content, attachments in
            if let entity = try? await ModelEntity(named: "Earth.usdz") {
                content.add(entity)
                entity.scale = [1,1,1]
                let _bounds = entity.model!.mesh.bounds.extents
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
                
                BillboardSystem.registerSystem()
                BillboardComponent.registerComponent()
                
                if let cardEntity = attachments.entity(for: textModel.id) {
                    
                    let billboardComponent = BillboardComponent()
                    cardEntity.components[BillboardComponent.self] = billboardComponent
                    
                    content.add(cardEntity)
                    cardEntity.look(at: .zero, from: textModel.location, relativeTo: cardEntity.parent)
                }
            }
        } attachments: {
            ForEach(textModelList) { textModel in
                Attachment(id: textModel.id) {
                    OrbitCard(name: textModel.text,
                                  description: textModel.descreption
                                  )
                }
            }
        }.gesture(
            SpatialTapGesture()
                .targetedToEntity(earthEntity)
                .onEnded { value in
                    let location = value.location3D
                    let convertedLocation = 2 * value.convert(location, from: .local, to: .scene)
                    textModelList.append(TextModel(text: "Earth:\(count)",location: convertedLocation))
                    count = count + 1
            }
        )
        .dragRotation(
            pitchLimit: .degrees(90)
        )
    }
}

#Preview {
    AttachmentOrbitView()
}
