/*
 このサンプルのライセンス情報については、LICENSE.txt ファイルを参照してください。
 
 抽象的な：
 添付ファイルとして使用され、関心のある地点に関する情報を提供するビュー。
 */

import SwiftUI
import RealityKit
import RealityKitContent

public struct LearnMoreView: View {
    
    let name: String
    let description: String
    let imageNames: [String]
    let trail: Entity?
    
    @State private var showingMoreInfo = false
    @Namespace private var animation
    
    private var imagesFrame: Double {
        showingMoreInfo ? 326 : 50
    }
    
    private var titleFont: Font {
        .system(size: 48, weight: .semibold)
    }
    
    private var descriptionFont: Font {
        .system(size: 36, weight: .regular)
    }
    
    public var body: some View {
        
        ZStack(alignment: .center) {
            if !showingMoreInfo {
                Text(name)
                    .matchedGeometryEffect(id: "Name", in: animation)
                    .font(titleFont)
                    .padding()
            }
            
            if showingMoreInfo {
                VStack(alignment: .leading, spacing: 10) {
                    Text(name)
                        .matchedGeometryEffect(id: "Name", in: animation)
                        .font(titleFont)
                    
                    Text(description)
                        .font(descriptionFont)
                    
                    if !imageNames.isEmpty {
                        Spacer()
                            .frame(height: 10)
                        
                        ImagesView(imageNames: imageNames)
                    }
                }
            }
        }
        .frame(width: 408)
        .padding(24)
        .background(.green.opacity(0.2))
        .glassBackgroundEffect(in: .rect(cornerRadius: 25))
        .onTapGesture {
            withAnimation(.spring) {
                showingMoreInfo.toggle()
                
            }
        }
        
    }
}

struct ImagesView: View {
    let imageNames: [String]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(imageNames, id: \.self) { imageName in
                    Image(systemName: "visionpro")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 250, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
    }
}

#Preview {
    RealityView { content, attachments in
        if let entity = attachments.entity(for: "z") {
            content.add(entity)
        }
    } attachments: {
        Attachment(id: "z") {
            LearnMoreView(name: "Phoenix Lake",
                          description: "Lake · Northern California",
                          imageNames: ["Landscape_2_Sunset"],
                          trail: nil
            )
        }
    }
}
