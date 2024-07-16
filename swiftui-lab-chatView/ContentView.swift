//
//  ContentView.swift
//  swiftui-lab-chatView
//
//  Created by Gab on 2024/07/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ChatView {
            Text("1")
                .background(.mint)
            
            Text("233")
                .frame(height: 30)
                .background(.blue)
        }
        .background(.pink)
        
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
