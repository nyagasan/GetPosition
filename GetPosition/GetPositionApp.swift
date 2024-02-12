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
            AttachmentLabelView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.7, height: 0.7, depth: 0.75, in: .meters)
        
    }
}
