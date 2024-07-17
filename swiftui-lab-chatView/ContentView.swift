//
//  ContentView.swift
//  swiftui-lab-chatView
//
//  Created by Gab on 2024/07/15.
//

import SwiftUI

struct ContentView: View {
    var list: [String] = [
        "111",
        "22222",
        "333",
//        "44444444",
//        "555",
//        "66666",
//        "77",
//        "88888888888",
//        "9999999",
//        "10101010",
//        "11 11 11 11",
//        "12 12 12 12 12 12 12 12"
    ]
    
    var body: some View {
        ChatView(list: list) { element in
            Text(element)
                .frame(height: 600)
                .background(.gray)
        }
        
//        ScrollView {
//            Text("1")
//                .background(.mint)
//            
//            Text("233")
//                .frame(height: 30)
//                .background(.blue)
//        }
    }
}

#Preview {
    ContentView()
}
