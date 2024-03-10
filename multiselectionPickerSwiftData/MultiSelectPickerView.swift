//
//  MultiSelectPickerView.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/30/23.
//

import SwiftUI
import SwiftData

struct MultiSelectPickerView: View {
    // https://stackoverflow.com/questions/77740750/swiftdata-issues-with-relationships-within-a-new-context-in-the-model-container
    var modelContext: ModelContext
    
    // The list of items we want to show
    @Binding var allItems: [SharedEntity]?
    var sortedAllItems: [SharedEntity] {
        get {
            (allItems ?? [SharedEntity]()).sorted(by: { $0.displayName > $1.displayName })
        }
        set {
            allItems = newValue
        }
    }

    // Binding to the selected items we want to track
    @Binding var selectedItems: [SharedEntity]?
    
    // add another shared entity
    @State private var newEntityName = ""

    var body: some View {
        VStack {
            Form { // Looks prettier (edge beside List) with form
                List {
                    ForEach(sortedAllItems, id: \.self) { item in
                        Button(action: {
                            print("Pressed| \(item.displayName)")
                            withAnimation {
                                // I think this is where it needs the same context
                                if self.selectedItems!.contains(item) {
                                    // Previous comment: you may need to adapt this piece
                                    print("REMOVING!")
                                    self.selectedItems!.removeAll(where: { $0.id == item.id })
                                } else {
                                    print("ADDING!")
                                    self.selectedItems!.append(item)
                                }
                                print("AFTER")
                            }
                        }) {
                            HStack {
                                Image(systemName: "checkmark")
                                    .opacity(self.selectedItems!.contains(item) ? 1.0 : 0.0)
                                Text(item.displayName)
                                Text("Selected: \(self.selectedItems!.contains(item) ? "yes" : "no")")
                            }
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
        }
        .onAppear() {
            if selectedItems == nil {
                selectedItems = [SharedEntity]()
            }
        }
    }
}
