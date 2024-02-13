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
        .defaultSize(width: 2, height: 2, depth: 2, in: .meters)
        
    }
}
