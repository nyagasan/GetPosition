//
//  HoverEffectView.swift
//  GetPosition
//
//  Created by Owner on 2024/02/12.
//

import SwiftUI
import RealityKit

struct HoverEffectView: View {
    var body: some View {
        VStack {
            // Forumから: https://developer.apple.com/forums/thread/734529?answerId=778990022#778990022
            // シュミレータで確認できるよ
            RealityView { content in
                let sphereResource = MeshResource.generateSphere(radius: 0.05)
                let myMaterial = SimpleMaterial(color: .blue, roughness: 0, isMetallic: true)
                let myEntity = ModelEntity(mesh: sphereResource, materials: [myMaterial])
                
                var collision = CollisionComponent(shapes: [.generateSphere(radius: 0.05)])
                collision.filter = CollisionFilter(group: [], mask: [])
                myEntity.components.set(collision)
                
                let input = InputTargetComponent(allowedInputTypes: .all)
                myEntity.components.set(input)
                
                let hoverComponent = HoverEffectComponent()
                myEntity.components.set(hoverComponent)
                
                content.add(myEntity)
            }
        }
        .frame(width: 800, height: 800)
        .padding(30)
        .background(.white)
    }
}

#Preview {
    HoverEffectView()
}
