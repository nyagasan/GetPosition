//
//  ChangeModelSize.swift
//  GetPosition
//
//  Created by Owner on 2024/02/12.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ChangeModelSize: View {
    
    @State var earthEntity: ModelEntity = ModelEntity()
    
    var body: some View {
        RealityView { content in
            if let entity = try? await ModelEntity(named: "Earth.usdz") {
                content.add(entity)
                entity.scale = [1,1,1]
                let bounds = entity.model!.mesh.bounds.extents
                entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
                entity.components.set(InputTargetComponent())
                earthEntity = entity
                
                // 現在のモデルのビジュアルサイズを取得
                let visualBoundsSize = entity.visualBounds(relativeTo: nil).size
                
                // 目標サイズを定義 (ここでは0.6メートル)
                let targetSize: Float = 0.6
                
                // スケール係数を計算（全ての次元で均等にスケールするため、1つの次元で計算）
                let scale = targetSize / visualBoundsSize.x // ここでは幅を基準にしている
                
                // スケールを適用
                entity.scale = SIMD3<Float>(repeating: scale)
                
                // 新しいサイズを出力
                let newSize = entity.visualBounds(relativeTo: nil).size
                print("New Size: Width: \(newSize.x) meters, Height: \(newSize.y) meters, Depth: \(newSize.z) meters")
                
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

// 拡張機能はGetPointViewのものを利用
//extension BoundingBox {
//    var size: SIMD3<Float> {
//        let width = max.x - min.x
//        let height = max.y - min.y
//        let depth = max.z - min.z
//        return [width, height, depth]
//    }
//}


#Preview {
    ChangeModelSize()
}
