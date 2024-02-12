import SwiftUI
import RealityKit
import RealityKitContent

struct GetPointView: View {

    @State var earthEntity: ModelEntity = ModelEntity()
    
    var body: some View {
        RealityView { content in
            if let entity = try? await ModelEntity(named: "Earth.usdz") {
                content.add(entity)
                entity.scale = [2,2,2]
                let bounds = entity.model!.mesh.bounds.extents
                entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
                entity.components.set(InputTargetComponent())
                earthEntity = entity
                
                /// entityのサイズを計算・出力する
                /// meshとして生成した時に使える
                let width = (entity.model?.mesh.bounds.max.x)! - (entity.model?.mesh.bounds.min.x)!
                let height = (entity.model?.mesh.bounds.max.y)! - (entity.model?.mesh.bounds.min.y)!
                let depth = (entity.model?.mesh.bounds.max.z)! - (entity.model?.mesh.bounds.min.z)!
                    
                let entitySize: SIMD3<Float> = [width, height, depth]
                    
                print("Hello",entitySize)
                
                /// Modelとして読み込む場合は.model!.mesh.bounds.extentsを使用するだけで良い
                print(bounds)
                
                ///SIMD3の値をBoundingBoxを使ってmeterに変換
                /// モデルのビジュアルバウンディングボックスのサイズを取得
                let visualBoundsSize = entity.visualBounds(relativeTo: nil).size
                /// サイズをコンソールに出力
                print("Width: \(visualBoundsSize.x) meters")
                print("Height: \(visualBoundsSize.y) meters")
                print("Depth: \(visualBoundsSize.z) meters")
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

extension BoundingBox {
    var size: SIMD3<Float> {
        let width = max.x - min.x
        let height = max.y - min.y
        let depth = max.z - min.z
        return [width, height, depth]
    }
}

#Preview {
    GetPointView()
}
