import SwiftUI
import RealityKit
import RealityKitContent

public struct OrbitCard: View {
    
    let name: String
    let description: String
 
    
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
                    Divider()
                    Text(description)
                        .font(descriptionFont)
                    Spacer()
                        .frame(height: 10)

                }
            }
        }
        .frame(width: 400)
        .padding(24)
        .background(.black.opacity(0.2))
        .glassBackgroundEffect(in: .rect(cornerRadius: 25))
        .onTapGesture {
            withAnimation(.spring) {
                showingMoreInfo.toggle()
                
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
            OrbitCard(name: "Phoenix Lake",
                          description: "Lake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern CaliforniaLake · Northern California"
            )
        }
    }
}
