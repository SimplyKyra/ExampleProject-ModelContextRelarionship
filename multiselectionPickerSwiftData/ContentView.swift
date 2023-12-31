//
//  ContentView.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/30/23.
//

import SwiftUI
// have data
// need to recreate creating the main, secondary with edit and simple sample for add
// move over multipicker
// hook it up on edit

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FirstTab()
                .tabItem {
                    Label("Main Entites", systemImage: "1.square.fill")
                }
            SecondTab()
                .tabItem {
                    Label("Add Shared", systemImage: "2.square.fill")
                }
            ThirdTab()
                .tabItem {
                    Label("Create Secondary with Shared", systemImage: "3.square.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
