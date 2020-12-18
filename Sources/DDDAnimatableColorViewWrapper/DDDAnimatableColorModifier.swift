import SwiftUI

public struct DDDAnimatableColorModifier<ChildView>: AnimatableModifier where ChildView: View {
    let from: Color
    let to: Color
    var pct: CGFloat
    let child: ChildView

    public var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    public init(from: Color, to: Color, pct: CGFloat, child: ChildView) {
        self.from = from
        self.to = to
        self.pct = pct
        self.child = child
    }

    public func body(content: Content) -> some View {
        return child.foregroundColor(colorMixer(c1: from, c2: to, pct: pct))
    }

    func colorMixer(c1: Color, c2: Color, pct: CGFloat) -> Color {
        #if os(iOS) || os(watchOS)
            guard let cc1 = UIColor(c1).cgColor.components else { return c1 }
            guard let cc2 = UIColor(c2).cgColor.components else { return c2 }
        #else
            guard let cc1 = NSColor(c1).cgColor.components else { return c1 }
            guard let cc2 = NSColor(c2).cgColor.components else { return c2 }
        #endif

        let r = (cc1[0] + (cc2[0] - cc1[0]) * pct)
        let g = (cc1[1] + (cc2[1] - cc1[1]) * pct)
        let b = (cc1[2] + (cc2[2] - cc1[2]) * pct)

        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
}
