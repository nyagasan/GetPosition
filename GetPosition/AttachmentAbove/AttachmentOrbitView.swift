import SwiftUI
import RealityKit

struct AttachmentOrbitView: View {
    @State var textModelList: [TextModel] = []
    @State var earthEntity: ModelEntity = ModelEntity()
    @State var count: Int = 0
//    @State var entityCenterPosition: Point3D = .zero
    
    var body: some View {
        RealityView { content, attachments in
            if let entity = try? await ModelEntity(named: "Earth.usdz") {
                content.add(entity)
                entity.scale = [1,1,1]
                let bounds = entity.model!.mesh.bounds.extents
                let visualBoundsSize = entity.visualBounds(relativeTo: nil).size //sizeはGetPointViewに書いてある拡張機能
                let targetSize: Float = 1
                let scale = targetSize / visualBoundsSize.x // ここでは幅を基準にしている
                entity.scale = SIMD3<Float>(repeating: scale)
                entity.collision = try? await CollisionComponent(shapes: [ShapeResource.generateConvex(from: entity.model!.mesh)])
                entity.components.set(InputTargetComponent())
                // 新しいサイズを出力
                let newSize = entity.visualBounds(relativeTo: nil).size
                print("New Size: Width: \(newSize.x) meters, Height: \(newSize.y) meters, Depth: \(newSize.z) meters")
                
                // エンティティのビジュアルバウンディングボックスを取得
                    let entitybounds = entity.visualBounds(relativeTo: nil)
                    
                    // Y軸の最高点を取得
                    let highestY = entitybounds.extents.y / 2.0 // Y軸の範囲は中心から上下に伸びるため、半分の値が最高点

                    // Y軸の最高点の座標をPoint3Dで取得
                    let highestPoint = Point3D(x: Double(entity.position.x),
                                               y: Double(entity.position.y) + Double(highestY),
                                               z: Double(entity.position.z))
                print(highestPoint)

                
//                print(entityCenterPosition)
                
                
                // 球体の中心座標
//                entity.position = .init(x: 0.5, y: 1.5, z: -0.5)
                
                
//                // 初期座標の設定
//                let anchor = AnchorEntity(.head)
//                anchor.anchoring.trackingMode = .once
//                entity.setParent(anchor)
//                entity.transform.translation.z = -0.75
//                entity.transform.translation.y = 0.1
//                
                earthEntity = entity
//                //中心座標渡し
//                let entityPositionSimd: SIMD3<Float> = earthEntity.position
//                entityCenterPosition = Point3D(x: Double(entityPositionSimd.x), y: Double(entityPositionSimd.y), z: Double(entityPositionSimd.z))
//                print(entity.position)
//                print(entityCenterPosition)
//
//                content.add(anchor)
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
                    let attachedLocation = 2 * value.location3D
                    let convertedLocation = 2 * value.convert(location, from: .local, to: .scene)
                    textModelList.append(TextModel(text: "Earth:\(count)",location: convertedLocation))
                    count = count + 1
                    print("ワイはここにおるで：球体の座標" ,location)
                    print("ワイはここにおるで：付箋の座標" ,attachedLocation)
                    print("ワイはここにおるで：SIMD3Dの座標" ,convertedLocation)
                    
//                    // 座標取得
//                    let parentLocation: Point3D = value.location3D
//                    let childLocation: Point3D = 2 * parentLocation
//
//                    // 象限移動
//                    var originLocation = Point3D(x: abs(childLocation.x) - abs(parentLocation.x),
//                                                 y: abs(childLocation.y) - abs(parentLocation.y),
//                                                 z: abs(childLocation.z) - abs(parentLocation.z))
//                    originLocation *= 2
//
//                    // 元の象限に戻す
//                    if childLocation.x < 0 {
//                        originLocation.x *= -1
//                    }
//                    if childLocation.y < 0 {
//                        originLocation.y *= -1
//                    }
//                    if childLocation.z < 0 {
//                        originLocation.z *= -1
//                    }
//
//                    // 原点軸から元に戻す
//                    originLocation = Point3D(x: originLocation.x + parentLocation.x,
//                                             y: originLocation.y + parentLocation.y,
//                                             z: originLocation.z + originLocation.z)
//
//                    // タップされた座標（地球の表面座標）
//                    let parentLocation: Point3D = value.location3D
//
//                    // 地球のオフセット中心座標（Point3Dに変換）
//                    let entityPositionSimd: SIMD3<Float> = earthEntity.position
//                    let entityPosition = Point3D(x: Double(entityPositionSimd.x), y: Double(entityPositionSimd.y), z: Double(entityPositionSimd.z))
//                    print(entityPosition)
//
//                    // 成分ごとに計算
//                    // (表面 - オフセット中心) * 2
//                    let diffX = (parentLocation.x - entityPosition.x) * 2
//                    let diffY = (parentLocation.y - entityPosition.y) * 2
//                    let diffZ = (parentLocation.z - entityPosition.z) * 2
//
//                    // 
//                    let resultX = diffX + entityPosition.x
//                    let resultY = diffY + entityPosition.y
//                    let resultZ = diffZ + entityPosition.z
//
//                    let resultLocation = Point3D(x: resultX, y: resultY, z: resultZ)
//                    
//                    let convertedLocation = value.convert(resultLocation, from: .local, to: .scene)
//                    textModelList.append(TextModel(text: "Earth:\(count)", location: convertedLocation))
//                    count = count + 1
//                    print("ワイはここにおるで：球体の座標", parentLocation)
//                    print("ワイはここにおるで：付箋の座標", convertedLocation)
                }

        )
        .dragRotation(
            initialPosition: Point3D([600, -1200.0, -1200]),
            pitchLimit: .degrees(90)
//            centerPosition: entityCenterPosition
        )
    }
    
}

// Point3D 同士の減算を定義
//extension Point3D {
//    static func -(lhs: Point3D, rhs: Point3D) -> Point3D {
//        return Point3D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
//    }
//}

//// Point3D の絶対値を定義
//extension Point3D {
//    var absoluteValue: Point3D {
//        return Point3D(x: fabs(x), y: fabs(y), z: fabs(z))
//    }
//}

#Preview {
    AttachmentOrbitView()
}
