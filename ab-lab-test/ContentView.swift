//
//  ContentView.swift
//  ab-lab-test
//
//  Created by jaddy on 6/4/25.
//

import SwiftUI
import TiaraSDK

struct ContentView: View {
    
    var body: some View {
        VStack {
            Button(action: {
                initId()
            }) {
                Text("id 변경")
            }
            Button(action: {
                trackPage()
            }) {
                Text("로그 전송")
            }
            Button(action: {
                flush()
            }) {
                Text("flush")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
