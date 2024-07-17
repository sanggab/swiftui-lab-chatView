//
//  ChatView.swift
//  swiftui-lab-chatView
//
//  Created by Gab on 2024/07/15.
//

import SwiftUI

//struct BoundsPreferenceKey: PreferenceKey {
//    typealias Bounds = Anchor<CGRect>
//    static var defaultValue = [Bounds]()
//
//    static func reduce(
//        value: inout [Bounds],
//        nextValue: () -> [Bounds]
//    ) {
//        value.append(contentsOf: nextValue())
//    }
//}

//struct CGPointPreferenceKey: PreferenceKey {
//    typealias Points = Anchor<CGPoint>
//    static var defaultValue = [Points]()
//
//    static func reduce(
//        value: inout [Points],
//        nextValue: () -> [Points]
//    ) {
//        value.append(contentsOf: nextValue())
//    }
//}

struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = [Int: Anchor<CGRect>]
    
    static var defaultValue: Value {
        [:]
    }
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue()) { $1 }
    }
}

struct ChatView<Content: View, Value>: View where Value: Hashable {
    
    var list: [Value]
    @ViewBuilder var content: (Value) -> Content
    
    @State private var boundList: [CGRect] = []
    
    @State private var contentSize: CGSize = .zero
    
    @State private var visibleRange: [Int: Bool] = [:]
    
    @Namespace var nameSpace
    var id: String = "content"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Array(list.enumerated()), id: \.element) { index, element in
                
                if visibleRange.isEmpty {
                    content(element)
                        .id(id)
                        .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds, transform: { anchor in
                            [index : anchor]
                        })
                } else {
                    
                    if visibleRange.first(where: { $0.key == index })?.value == true {
                        
                        content(element)
                            .id(id)
                            .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds, transform: { anchor in
                                [index : anchor]
                            })
                    } else {
                        
                        content(element)
                            .id(id)
                            .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds, transform: { anchor in
                                [index : anchor]
                            })
                            .hidden()
                    }
                }
//                    .anchorPreference(key: CGPointPreferenceKey.self, value: ., transform: { anchor in
//                        [index : anchor]
//                    })
            }
        }
//        .background {
//            GeometryReader { proxy in
//                Color.clear
//                    .onPreferenceChange(BoundsPreferenceKey.self, perform: { value in
//                        let bounds: [CGRect] = value.map { proxy[$0] }
//                        print("bounds: \(bounds)")
//                    })
//            }
//        }
//        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
//            GeometryReader { proxy in
//                Color.clear
//                    .onChange(of: value) { newValue in
//                        let bounds: [CGRect] = newValue.map { proxy[$0] }
//                        print("bounds: \(bounds)")
//                    }
//            }
//        }
        .backgroundPreferenceValue(BoundsPreferenceKey.self) { value in
            GeometryReader { proxy in
                Color.clear
                    .onChange(of: value) { newValue in
                        value.forEach { key, value in
                            let minY = proxy[value].minY
                            let maxY = proxy[value].maxY
                            
                            if minY <= proxy.size.height && maxY >= 0 {
                                visibleRange.merge([key : true]) { $1 }
                            } else {
                                visibleRange.merge([key : false]) { $1 }
                            }
                            
                        }
                    }
            }
        }
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
