import SwiftUI
import RealityKit
import RealityKitContent

struct GetPointView: View {
    var body: some View {
        RealityView { content in
            do {
                // Anchorオブジェクトの作成
                let anchor = AnchorEntity()
                // ModelEntityのロード
                let loadEntity = try await Entity(named: "Neptune", in: realityKitContentBundle)
                // AnchorをModelEntityの親に指定
                loadEntity.setParent(anchor)
                // いつもの表示するやつ
                content.add(anchor)
            } catch {
                print("Error loading model \(error)")
            }
        }

    }
}

#Preview {
    GetPointView()
}
