//
//  ThirdTab.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/31/23.
//

import SwiftUI
import SwiftData

struct ThirdTab: View {
    // to delete
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \MainEntity.displayName, order: .forward) var allMainEntities: [MainEntity]
    @State var selectedEntity: MainEntity? = nil
    
    // add secondary entity
    @State private var newEntityName = ""
    @State private var showEditEntity: SecondaryEntity?
    
    // Wrapping the Secondary array in a computed property to handle sorting for us.
    var sortedSecondaryEntities: [SecondaryEntity] {
        (selectedEntity?.secondaryEntities ?? [SecondaryEntity]()).sorted {
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
                Text("You must select a main entity to see and edit the secondary entities.")
                    .padding()
            } else {
                HStack {
                    TextField("Add a Secondary entity to \(selectedEntity!.displayName)", text: $newEntityName)
                    Button("Add", action: addSecondaryEntity)
                }
                
                ForEach(sortedSecondaryEntities) { thisSecondaryEntity in
                    Button(thisSecondaryEntity.displayName, action: {
                        showEditEntity = thisSecondaryEntity
                    })
                }
                .onDelete(perform: deleteSecondaryEntities)
                
            }
        }
        .padding()
        .sheet(item: $showEditEntity, content: { thisValue in
            EditSecondary(secondaryEntityID: thisValue.persistentModelID, in: modelContext.container)
        })
    }
    
    func addSecondaryEntity() {
        guard newEntityName.isEmpty == false else { return }
        
        withAnimation {
            let _ = SecondaryEntity(displayName: newEntityName, mainEntity: selectedEntity)
            newEntityName = ""
        }
    }
    
    func deleteSecondaryEntities(_ indexSet: IndexSet) {
        for index in indexSet {
            let SecondaryEntity = sortedSecondaryEntities[index]
            modelContext.delete(SecondaryEntity)
        }
    }
}

#Preview {
    ThirdTab()
}
