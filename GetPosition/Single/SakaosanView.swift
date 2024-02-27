import SwiftUI
import RealityKit
import RealityKitContent

struct SakaosanView: View {

    @State var earthEntity: ModelEntity = ModelEntity()
    
    var body: some View {
        // テクスチャが表示されなかった
        RealityView { content in
            if let entity = try? await ModelEntity(named: "Sakaosan.usdz") {
                content.add(entity)
                entity.scale = [0.5,0.5,0.5]
                entity.position = [0, -0.05, 0]
                let bounds = entity.model!.mesh.bounds.extents
                entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
                entity.components.set(InputTargetComponent())
                earthEntity = entity
                /// モデルのビジュアルバウンディングボックスのサイズを取得
                let visualBoundsSize = entity.visualBounds(relativeTo: nil).size
                /// サイズをコンソールに出力
                print("さかおさんのWidth: \(visualBoundsSize.x) meters","Height: \(visualBoundsSize.y) meters", "Depth: \(visualBoundsSize.z) meters")
            }
        }.gesture(
            SpatialTapGesture()
                .targetedToEntity(earthEntity)
                .onEnded { value in
                    let location = value.location3D
                    let convertedLocation = 1.05 * value.convert(location, from: .local, to: .scene)
                    print("ワイはここにおるで" ,location)
                }
        )
    }
}

#Preview {
    SakaosanView()
}
