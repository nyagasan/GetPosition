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
        Model3D(named: "Neptune", bundle: realityKitContentBundle)
        RealityView { content,_ in
            if let entity = try? await ModelEntity(named: "Neptune", in: realityKitContentBundle) {
                content.add(entity)
                entity.scale = SIMD3(0.0015, 0.0015, 0.0015)
                neptuneEntity = entity
            }
        } update: { _, attachments in
            if let text = attachments.entity(for: "h_t") {
                text.position = neptuneEntity.position + [0, 0.2, 0]
                neptuneEntity.addChild(text, preservingWorldTransform: true)
            }
        } attachments: {
            Attachment(id: "h_t") {
                Text("Hello")
                    .tag("h_t")
            }
        }

    }
}

#Preview {
    GetPointView()
}
