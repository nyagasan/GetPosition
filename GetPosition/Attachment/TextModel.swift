import Foundation

struct TextModel: Identifiable {
    var id = UUID()
    var text: String
    var descreption =  "\(UUID())"
    var location: SIMD3<Float>
}
