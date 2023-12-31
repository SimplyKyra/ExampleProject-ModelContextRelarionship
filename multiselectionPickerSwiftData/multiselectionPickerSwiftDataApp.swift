//
//  multiselectionPickerSwiftDataApp.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/30/23.
//

import SwiftUI
import SwiftData

@main
struct multiselectionPickerSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: MainEntity.self)
    }
}
