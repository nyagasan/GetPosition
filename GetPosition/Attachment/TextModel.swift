import Foundation

struct TextModel: Identifiable {
    var id = UUID()
    var text: String
    var location: SIMD3<Float>
}
