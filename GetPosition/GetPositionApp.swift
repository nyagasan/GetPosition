//
//  GetPositionApp.swift
//  GetPosition
//
//  Created by Owner on 2024/02/11.
//

import SwiftUI

@main
struct GetPositionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.3, height: 1.3, depth: 1.3, in: .meters)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            AttachmentOrbitView()
        }.immersionStyle(selection: .constant(.mixed), in: .mixed)
        
    }
}
