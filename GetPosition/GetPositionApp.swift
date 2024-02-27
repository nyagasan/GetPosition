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
        WindowGroup(id: "Top") {
            TopMenuView()
        }
        .windowStyle(.plain)
        
        WindowGroup(id:"DragGesture") {
            DragGestureView()
        }.windowStyle(.volumetric)
            .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        
        WindowGroup(id: "HoverEffectView") {
            HoverEffectView()
        }.windowStyle(.plain)
        
        WindowGroup(id: "GetPoint") {
            GetPointView()
        }.windowStyle(.volumetric)
            .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        
        WindowGroup(id: "Magnify") {
            MagnifyGestureView()
        }.windowStyle(.automatic)
        
        WindowGroup(id: "Sakao") {
            SakaosanView()
        }.windowStyle(.volumetric)
            .defaultSize(width: 0.6, height: 1.2, depth: 0.6, in: .meters)
        
//        WindowGroup(id: "ModelHover") {
//            ModelHoverEffectView()
//        }.windowStyle(.automatic)
        
        WindowGroup(id: "ModelDrag") {
            ModelDragGestureView()
        }.windowStyle(.automatic)
        
        WindowGroup(id: "DragMove") {
            DragMoveView()
        }.windowStyle(.automatic)
        
        WindowGroup(id: "ScalableRotate") {
            ScalableRotateView()
        }.windowStyle(.automatic)
        
        WindowGroup(id: "Attachment") {
            AttachmentLabelView()
        }.windowStyle(.volumetric)
            .defaultSize(width: 1.2, height: 1.2, depth: 1.2, in: .meters)
        
//        ImmersiveSpace(id: "ImmersiveSpace") {
//            SakaosanView()
//        }.immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
