//
//  TopMenuView.swift
//  GetPosition
//
//  Created by Owner on 2024/02/27.
//

import SwiftUI
import RealityKit

struct TopMenuView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Single Gesture")
                    .font(.title)
                List {
                    Button(action: {
                        openWindow(id: "DragGesture")
                    }, label: {
                        Text("DragGesture")
                    })
                    Button(action: {
                        openWindow(id: "HoverEffectView")
                    }, label: {
                        Text("HoverEffectView")
                    })
                    Button(action: {openWindow(id: "GetPoint")}, label: {
                        Text("GetPoint")
                    })
                    Button(action: {openWindow(id: "Magnify")}, label: {
                        Text("MagnifyGesture")
                    })
                    Button(action: {openWindow(id: "Sakao")}, label: {
                        Text("Sakao-san")
                    })
                    Button(action: {openWindow(id: "ModelHover")}, label: {
                        Text("ModelHover")
                    })
                    Button(action: {openWindow(id: "ModelDrag")}, label: {
                        Text("ModelDrag")
                    })
                    Button(action: {openWindow(id: "DragMove")}, label: {
                        Text("DragMove")
                    })
                }
                Text("Multiple")
                    .font(.title)
                List {
                    Button(action: {openWindow(id: "ScalableRotate")}, label: {
                        Text("ScalableRotate")
                    })
                }
                Text("Attachment")
                    .font(.title)
                List {
                    Button(action: {openWindow(id: "Attachment")}, label: {
                        Text("AttachmentLabel")
                    })
                }
            }
            .padding(.horizontal,50)
            .navigationTitle("Get Position TestApp")
        }
    }
}

#Preview {
    TopMenuView()
}
