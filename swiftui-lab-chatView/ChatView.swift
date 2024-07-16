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
    
    @State private var boundList: [CGRect] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            content()
        }
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        let bounds: [CGRect] = value.map { proxy[$0] }
                        print("bounds: \(bounds)")
                        print("bounds count \(bounds.count)")
                        boundList = bounds
                    }
            }
        }
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        print("proxy size:  \(proxy.size)")
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

public extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

//content()
//    .alignmentGuide(.top, computeValue: { d in
//        let height: CGFloat = boundList[safe: index - 1]?.height ?? .zero
//        
//        print("height: \(height)")
//        
//        index += 1
//        
//        return -height
//    })
//    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds, transform: { anchor in
//        [anchor]
//    })
//
//Color.clear
//    .alignmentGuide(.top, computeValue: { _ in
//        index = .zero
//        
//        return .zero
//    })
