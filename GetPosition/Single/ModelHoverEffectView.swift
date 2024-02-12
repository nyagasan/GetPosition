//
//  ModelHoverEffectView.swift
//  GetPosition
//
//  Created by Owner on 2024/02/12.
//

import SwiftUI
import RealityKit
import RealityKitContent


// フォーカス当たった時にHoverEfectsComponentを発動
// https://1planet.co.jp/tech-blog/applevisionpro-oneplanet-realityview-modelentity-focus
struct ModelHoverEffectView: View {
    var body: some View {
        RealityView { content in
            do {
                let entity = try! await ModelEntity(named: "Neptune")
                let bounds = entity.model!.mesh.bounds.extents
                entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
                entity.components.set(HoverEffectComponent())
                entity.components.set(InputTargetComponent())
                content.add(entity)
            } catch {
                print("Error loading model \(error)")
            }
        }
        
    }
}
#Preview {
    ModelHoverEffectView()
}
