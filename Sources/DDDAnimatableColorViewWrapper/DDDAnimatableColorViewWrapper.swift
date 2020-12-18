import SwiftUI

public struct DDDAnimatableColorViewWrapper<ChildView>: View where ChildView: View {
    let from: Color
    let to: Color
    let pct: CGFloat
    let child: () -> ChildView
    
    public init(from: Color, to: Color, pct: CGFloat, child: @escaping () -> ChildView) {
        self.from = from
        self.to = to
        self.pct = pct
        self.child = child
    }

    public var body: some View {
        let childView = child()
        return childView
            .foregroundColor(Color.clear)
            .overlay(Color.clear.modifier(DDDAnimatableColorModifier(from: from, to: to, pct: pct, child: childView)))
    }
}
