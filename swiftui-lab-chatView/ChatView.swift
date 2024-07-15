//
//  ChatView.swift
//  swiftui-lab-chatView
//
//  Created by Gab on 2024/07/15.
//

import SwiftUI

struct BoundsPreferenceKey: PreferenceKey {
    typealias Bounds = Anchor<CGRect>
    static var defaultValue = [Bounds]()

    static func reduce(
        value: inout [Bounds],
        nextValue: () -> [Bounds]
    ) {
        value.append(contentsOf: nextValue())
    }
}

struct CGPointPreferenceKey: PreferenceKey {
    typealias Points = Anchor<CGPoint>
    static var defaultValue = [Points]()

    static func reduce(
        value: inout [Points],
        nextValue: () -> [Points]
    ) {
        value.append(contentsOf: nextValue())
    }
}

struct ChatView<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                content()
                    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds, transform: { anchor in
                        [anchor]
                    })
            }
        }
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        let bounds: [CGRect] = value.map { proxy[$0] }
                        print("bounds: \(bounds)")
                        print("bounds count \(bounds.count)")
                    }
            }
        }
    }
}

#Preview {
    ChatView {
        Text("1")
    }
}

