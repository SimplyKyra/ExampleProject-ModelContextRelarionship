//
//  EditSecondary.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/31/23.
//

import SwiftUI
import SwiftData

struct EditSecondary: View {
    @Environment(\.dismiss) var dismiss
    var modelContext: ModelContext
    
    // The entity being recreated to be edited
    @Bindable var secondaryEntity: SecondaryEntity
    
    init(secondaryEntityID: PersistentIdentifier, in container: ModelContainer) {
        modelContext = ModelContext(container)
        modelContext.autosaveEnabled = false
        secondaryEntity = modelContext.model(for: secondaryEntityID) as? SecondaryEntity ?? SecondaryEntity()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Name:")
                        TextField("Name", text: $secondaryEntity.displayName)
                    }
                }
                Section("Assigned Entities") {
                    NavigationLink(destination: {
                        MultiSelectPickerView(modelContext: modelContext, allItems: .constant(secondaryEntity.mainEntity?.sharedEntities ?? [SharedEntity]()), selectedItems: $secondaryEntity.sharedEntities)
                            .navigationTitle("Choose Assigned Colors")
                    }, label: {
                        HStack {
                            Text("Select Colors:").foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "\(secondaryEntity.sharedEntities?.count ?? 0).circle")
                                .foregroundColor(.primary)
                                .font(.title2)
                        }
                    })
//                    
                    ForEach(secondaryEntity.mainEntity?.sharedEntities ?? [SharedEntity]()) { thisItem in
                        HStack {
                            if secondaryEntity.sharedEntities?.first(where: { $0 == thisItem }) != nil {
                                Text("Attachend")
                            } else {
                                Text("NOT")
                            }
                            Text(thisItem.displayName)
                        }
                    }
                }
            }
        }
    }
}
        

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: SecondaryEntity.self, configurations: config)
        
        let example = SecondaryEntity(displayName: "Example")
        
        return EditSecondary(secondaryEntityID: example.id, in: container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
