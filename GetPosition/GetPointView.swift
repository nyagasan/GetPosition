//
//  GetPointView.swift
//  GetPosition
//
//  Created by Owner on 2024/02/11.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct GetPointView: View {
    
    @State var neptuneEntity: ModelEntity = ModelEntity()
    
    var body: some View {
//        Model3D(named: "Neptune", bundle: realityKitContentBundle)
        RealityView { content in
            if let entity = try? await ModelEntity(named: "Neptune") {
                let bounds = entity.model!.mesh.bounds.extents
                entity.components.set(CollisionComponent(shapes: [.generateBox(size: bounds)]))
                entity.components.set(HoverEffectComponent())
                entity.components.set(InputTargetComponent())
                content.add(entity)
            }
        }
    }
}

#Preview {
    GetPointView()
}
