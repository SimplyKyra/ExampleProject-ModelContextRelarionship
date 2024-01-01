//
//  MainTab.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/31/23.
//

import SwiftUI
import SwiftData

struct FirstTab: View {
    // to delete
    @Environment(\.modelContext) private var modelContext
    
    // add main entity
    @State private var newEntityName = ""
    
    @Query(sort: \MainEntity.displayName, order: .forward) var allMainEntities: [MainEntity]
    
    var body: some View {
        VStack {
            Button(action: {
                for entity in allMainEntities {
                    modelContext.delete(entity)
                }
            }, label: {
                Text("Delete ALL")
            })
            Spacer()
            Text("Main Entites:")
            Divider()
            
            HStack {
                TextField("Add a main entity", text: $newEntityName)
                Button("Add", action: addMainEntity)
            }
            
            
            ForEach(allMainEntities) { thisMainEntity in
                Text(thisMainEntity.displayName)
            }
            .onDelete(perform: deleteMainEntities)
            Spacer()
        }
        .padding()
    }
    
    
    func addMainEntity() {
        guard newEntityName.isEmpty == false else { return }
        
        withAnimation {
            let thisEntity = MainEntity(displayName: newEntityName)
            modelContext.insert(thisEntity)
            newEntityName = ""
        }
    }
    
    func deleteMainEntities(_ indexSet: IndexSet) {
        for index in indexSet {
            let mainEntity = allMainEntities[index]
            modelContext.delete(mainEntity)
        }
    }
}

#Preview {
    FirstTab()
}
