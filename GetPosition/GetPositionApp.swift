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
            GetPointView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        
    }
}
