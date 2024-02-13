import SwiftUI
import RealityKit

extension View {
    // Appleが作ったDrag用モディファイア
    /// オプションの制限付きで、エンティティをドラッグして回転できるようにします
     /// ヨーとピッチの回転について。
    func dragRotation(
        initialPosition: Point3D = .zero,
        yawLimit: Angle? = nil,
        pitchLimit: Angle? = nil,
        sensitivity: Double = 10,
        axRotateClockwise: Bool = false,
        axRotateCounterClockwise: Bool = false
    ) -> some View {
        self.modifier(
            DragRotationModifier(
                initialPosition: initialPosition,
                yawLimit: yawLimit,
                pitchLimit: pitchLimit,
                sensitivity: sensitivity,
                axRotateClockwise: axRotateClockwise,
                axRotateCounterClockwise: axRotateCounterClockwise
            )
        )
    }
}

/// モディファイアは、ドラッグ ジェスチャをエンティティの回転に変換します。
private struct DragRotationModifier: ViewModifier {
    var initialPosition: Point3D
    var yawLimit: Angle?
    var pitchLimit: Angle?
    var sensitivity: Double
    var axRotateClockwise: Bool
    var axRotateCounterClockwise: Bool

    @State private var position: Point3D = .zero
    
    @State private var baseYaw: Double = 0
    @State private var yaw: Double = 0
    @State private var basePitch: Double = 0
    @State private var pitch: Double = 0

    func body(content: Content) -> some View {
        content
            .onAppear {
                position = initialPosition
            }
            .position(x: position.x, y: position.y)
            .offset(z: position.z)
            .rotation3DEffect(.radians(yaw == 0 ? 0.01 : yaw), axis: .y, anchor: Point3D([600, -1500.0, -1200]).toUnitPoint3D())
            .rotation3DEffect(.radians(pitch == 0 ? 0.01 : pitch), axis: .x, anchor: Point3D([600, -1500.0, -1200]).toUnitPoint3D())
            .gesture(DragGesture(minimumDistance: 0.0)
                .targetedToAnyEntity()
                .onChanged { value in
                    // 現在の線形変位を求めます。
                    let location3D = value.convert(value.location3D, from: .local, to: .scene)
                    let startLocation3D = value.convert(value.startLocation3D, from: .local, to: .scene)
                    let delta = location3D - startLocation3D

                    // 次のようなインタラクティブなスプリング アニメーションを使用します。
                     // ジェスチャが以下で終了したときのスプリング アニメーション。
                    withAnimation(.interactiveSpring) {
                        yaw = spin(displacement: Double(delta.x), base: baseYaw, limit: yawLimit)
                        pitch = spin(displacement: Double(delta.y), base: basePitch, limit: pitchLimit)
                    }
                }
                .onEnded { value in
                    // 現在および予測される最終的な線形変位を求めます。
                    let location3D = value.convert(value.location3D, from: .local, to: .scene)
                    let startLocation3D = value.convert(value.startLocation3D, from: .local, to: .scene)
                    let predictedEndLocation3D = value.convert(value.predictedEndLocation3D, from: .local, to: .scene)
                    let delta = location3D - startLocation3D
                    let predictedDelta = predictedEndLocation3D - location3D

                    // スプリング アニメーションを使用して最終的なスピン値を設定します。
                    withAnimation(.spring) {
                        yaw = finalSpin(
                            displacement: Double(delta.x),
                            predictedDisplacement: Double(predictedDelta.x),
                            base: baseYaw,
                            limit: yawLimit)
                        pitch = finalSpin(
                            displacement: Double(delta.y),
                            predictedDisplacement: Double(predictedDelta.y),
                            base: basePitch,
                            limit: pitchLimit)
                    }

                    // 次のジェスチャで使用するために最後の値を保存します。
                    baseYaw = yaw
                    basePitch = pitch
                }
            )
            .onChange(of: axRotateClockwise) {
                withAnimation(.spring) {
                    yaw -= (.pi / 6)
                    baseYaw = yaw
                }
            }
            .onChange(of: axRotateCounterClockwise) {
                withAnimation(.spring) {
                    yaw += (.pi / 6)
                    baseYaw = yaw
                }
            }
    }

    /// 指定された線形変位のスピンを求めます。
     /// オプションの制限。
    private func spin(
        displacement: Double,
        base: Double,
        limit: Angle?
    ) -> Double {
        if let limit {
            return atan(displacement * sensitivity) * (limit.degrees / 90)
        } else {
            return base + displacement * sensitivity
        }
    }

    /// 現在および予測された最終線形を考慮して最終スピンを見つけます
     /// 変位、またはスピンが制限されている場合はゼロ。
    private func finalSpin(
        displacement: Double,
        predictedDisplacement: Double,
        base: Double,
        limit: Angle?
    ) -> Double {
        // スピン制限がある場合は、最後に必ずゼロスピンに戻ります。
        guard limit == nil else { return 0 }

        // あと 1 回転を上限として、予測される最終線形変位を求めます。
        let cap = .pi * 2.0 / sensitivity
        let delta = displacement + max(-cap, min(cap, predictedDisplacement))

        // 最後のスピンを見つけます。
        return base + delta * sensitivity
    }
}


extension Point3D {
    func toUnitPoint3D() -> UnitPoint3D {
        let length = sqrt(x * x + y * y + z * z)
        return UnitPoint3D(x: x / length, y: y / length, z: z / length)
    }
}
