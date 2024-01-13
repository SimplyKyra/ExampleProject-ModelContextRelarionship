//
//  SecondaryTab.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/31/23.
//

import SwiftUI
import SwiftData

struct SecondTab: View {
    // to delete
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \MainEntity.displayName, order: .forward) var allMainEntities: [MainEntity]
    @State var selectedEntity: MainEntity? = nil
    
    // add shared entity
    @State private var newEntityName = ""
    
    // Wrapping the shared array in a computed property to handle sorting for us.
    var sortedSharedEntities: [SharedEntity] {
        (selectedEntity?.sharedEntities ?? [SharedEntity]()).sorted {
            $0.displayName < $1.displayName
        }
    }
    
    var body: some View {
        VStack {
            Menu {
                ForEach(allMainEntities, id:\.self) { thisEntity in
                    Button(thisEntity.displayName) {
                        selectedEntity = thisEntity
                    }
                }
            } label: {
                HStack {
                    if selectedEntity == nil {
                        Text("Select entity to continue.")
                    } else  {
                        Text(selectedEntity!.displayName)
                            .bold()
                            .lineLimit(1)
                    }
                    Image(systemName: "chevron.down")
                        .bold()
                }
                .padding(.horizontal)
            }
            Divider()
            
            if selectedEntity == nil {
                Text("You must select a main entity to see and edit the associated shared entities.")
                    .padding()
            } else {
                HStack {
                    TextField("Add a shared entity to \(selectedEntity!.displayName)", text: $newEntityName)
                    Button("Add", action: addSharedEntity)
                }
                
                ForEach(sortedSharedEntities) { thisSharedEntity in
                    Text(thisSharedEntity.displayName)
                }
                .onDelete(perform: deleteSharedEntities)
                
            }
        }
        .onAppear() {
            selectedEntity = allMainEntities.first
        }
        .padding()
    }
    
    func addSharedEntity() {
        guard newEntityName.isEmpty == false else { return }
        
        withAnimation {
            let _ = SharedEntity(displayName: newEntityName, mainEntity: selectedEntity)
            newEntityName = ""
        }
    }
    
    func deleteSharedEntities(_ indexSet: IndexSet) {
        for index in indexSet {
            let sharedEntity = sortedSharedEntities[index]
            modelContext.delete(sharedEntity)
        }
    }
    
}

#Preview {
    SecondTab()
}
