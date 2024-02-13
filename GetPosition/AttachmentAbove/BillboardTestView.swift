//
//  BillboardTestView.swift
//  GetPosition
//
//  Created by Owner on 2024/02/13.
//

import SwiftUI
import RealityKit

struct BillboardTestView: View {
    var body: some View {
        RealityView { content, attachments in
            BillboardSystem.registerSystem()
            BillboardComponent.registerComponent()
            
            if let entity = attachments.entity(for: "previewTag") {

                let billboardComponent = BillboardComponent()
                entity.components[BillboardComponent.self] = billboardComponent
                
                content.add(entity)
            }
        } attachments: {
            Attachment(id: "previewTag") {
                OrbitCard(name: "Phoenix Lake",
                              description: "Lake · Northern CaliforniaLake · Northern California"
                )
            }
        }
    }
}

#Preview {
    BillboardTestView()
}
