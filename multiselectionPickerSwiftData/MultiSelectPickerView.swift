//
//  MultiSelectPickerView.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/30/23.
//

import SwiftUI
import SwiftData

struct MultiSelectPickerView: View {
    var modelContext: ModelContext

    // The list of items we want to show
    @State var allItems: [SharedEntity] = [SharedEntity]()

    // mainEntity to refresh the list of items
    @State var mainEntity: MainEntity?

    // Binding to the selected items we want to track
    @Binding var selectedItems: [SharedEntity]?

//    // Allow adding new shared Entities
//    @State private var showingAddSharedEntity = false
//    @State private var newSharedEntity: SharedEntity?
    
    // add another shared entity
    @State private var newEntityName = ""

    var body: some View {
        VStack {
            if allItems.count == 0 {
                Text("There are no categories. Please add to begin.")
                    .padding([.leading, .trailing, .bottom], 5)
                    .multilineTextAlignment(.center)
            } else {
                Text("If you select too many categories and/or label them with long names they may be hidden on the reMarkable. I like to only add one or two small names.")
                    .padding([.leading, .trailing, .bottom], 5)
                    .multilineTextAlignment(.center)
            }
            
            HStack {
                TextField("Add a shared entity", text: $newEntityName)
                Button("Add", action: addSharedEntity)
            }
            
//            Button(action: {
//                showingAddSharedEntity = true
//            }, label: {
//                Label("Create New SharedEntity", systemImage: "plus")
//            })

            Form { // Looks prettier (edge beside List) with form
                List {
                    ForEach(allItems, id: \.self) { item in
                        Button(action: {
                            withAnimation {
                                // I think this is where it needs the same context
                                if self.selectedItems!.contains(item) {
                                    // Previous comment: you may need to adapt this piece
                                    self.selectedItems!.removeAll(where: { $0 == item })
                                } else {
                                    self.selectedItems!.append(item)
                                }
                            }
                            // Force a save before editing so it's in the system on return
                            do {
                                try modelContext.save()
                            } catch {
                                print("Catch: \(error)")
                            }
                            
                        }) {
                            HStack {
                                Image(systemName: "checkmark")
                                    .opacity(self.selectedItems!.contains(item) ? 1.0 : 0.0)
                                Text(item.displayName)
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
            allItems = mainEntity?.sharedEntities ?? [SharedEntity]()
        }
    }

    private func addSharedEntity() {
        let _ = SharedEntity(displayName: newEntityName, mainEntity: mainEntity)
        newEntityName = ""
        // Force a save before editing so it's in the system on return
        do {
            try modelContext.save()
        } catch {
            print("Catch: \(error)")
        }
        
        allItems = mainEntity?.sharedEntities ?? [SharedEntity]()
    }
}

#Preview {
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: SecondaryEntity.self, configurations: config)
        
        return MultiSelectPickerView(modelContext: container.mainContext, allItems: [SharedEntity](), mainEntity: MainEntity(displayName: "Example"), selectedItems: .constant([SharedEntity]()))
    } catch {
        fatalError("Failed to create model container.")
    }
}

/*
 
 // Attempted
 //
 
 
 //  MultiSelectPickerView.swift
 //  multiselectionPickerSwiftData
 //
 //  Created by Kyra Delaney on 12/30/23.
 //

 import SwiftUI
 import SwiftData

 struct MultiSelectPickerView: View {
     var modelContext: ModelContext

     // The list of items we want to show
     @State var allItems: [SharedEntity] = [SharedEntity]()

     // mainEntity to refresh the list of items - pass by id
     @State var mainEntity: MainEntity?

     // Binding to the selected items we want to track
     @Binding var selectedItems: [SharedEntity]?

 //    // Allow adding new shared Entities
 //    @State private var showingAddSharedEntity = false
 //    @State private var newSharedEntity: SharedEntity?
     
     // add another shared entity
     @State private var newEntityName = ""
     
     // MultiSelectPickerView(modelContext: container.mainContext, allItems: [SharedEntity](), mainEntity: MainEntity(displayName: "Example"), selectedItems: .constant([SharedEntity]()))
     
     
     init(mainEntityID: PersistentIdentifier,
          in container: ModelContainer,
          selectedItems: Binding<[SharedEntity]?>) {
         modelContext = ModelContext(container)
         modelContext.autosaveEnabled = false
         mainEntity = modelContext.model(for: mainEntityID) as? MainEntity ?? MainEntity()
         
         _selectedItems = selectedItems
         print("About to do loop")
         for thisItem in mainEntity?.sharedEntities ?? [SharedEntity]() {
             print("\(thisItem.persistentModelID)")
             if let thisItemContext =  modelContext.model(for: thisItem.persistentModelID) as? SharedEntity {
                 allItems.append(thisItemContext)
                 print(thisItemContext.displayName)
             }
         }
 //        allItems = mainEntity?.sharedEntities ?? [SharedEntity]()
         
         
         print("init for \(mainEntity?.displayName)")
         print("this has \(mainEntity?.sharedEntities?.count) shased items")
         
         print("AllItems: \(allItems.count)")
         print("SELECTED: \(selectedItems.wrappedValue?.count) selected ones")
     }
     

     var body: some View {
         VStack {
             if (mainEntity?.sharedEntities ?? [SharedEntity]()).count == 0 {
                 Text("There are no categories. Please add to begin.")
                     .padding([.leading, .trailing, .bottom], 5)
                     .multilineTextAlignment(.center)
             } else {
                 Text("If you select too many categories and/or label them with long names they may be hidden on the reMarkable. I like to only add one or two small names.")
                     .padding([.leading, .trailing, .bottom], 5)
                     .multilineTextAlignment(.center)
             }
             
             HStack {
                 TextField("Add a shared entity", text: $newEntityName)
                 Button("Add", action: addSharedEntity)
             }
             
 //            Button(action: {
 //                showingAddSharedEntity = true
 //            }, label: {
 //                Label("Create New SharedEntity", systemImage: "plus")
 //            })

             Form { // Looks prettier (edge beside List) with form
                 Text("All Items Count: \((mainEntity?.sharedEntities ?? [SharedEntity]()).count)")
                 List {
                     ForEach((mainEntity?.sharedEntities ?? [SharedEntity]()), id: \.self) { item in
                         Button(action: {
                             withAnimation {
                                 // I think this is where it needs the same context
                                 if self.selectedItems?.first(where: { $0 == item }) != nil {
                                     // Previous comment: you may need to adapt this piece
                                     self.selectedItems?.removeAll(where: { $0 == item })
                                 } else {
                                     self.selectedItems?.append(item)
                                 }
                             }
                             // Force a save before editing so it's in the system on return
                             do {
                                 try modelContext.save()
                             } catch {
                                 print("Catch: \(error)")
                             }
                             
                         }) {
                             HStack {
                                 Image(systemName: "checkmark")
                                     .opacity(self.selectedItems?.first(where: { $0 == item }) != nil ? 1.0 : 0.0)
                                 Text(item.displayName)
                             }
                         }
                         .foregroundColor(.primary)
                     }
                 }
             }
         }
 //        .onAppear() {
 //            if selectedItems == nil {
 //                selectedItems = [SharedEntity]()
 //            }
 //            allItems = mainEntity?.sharedEntites ?? [SharedEntity]()
 //        }
     }

     private func addSharedEntity() {
         let _ = SharedEntity(displayName: newEntityName, mainEntity: mainEntity)
         newEntityName = ""
         // Force a save before editing so it's in the system on return
         do {
             try modelContext.save()
         } catch {
             print("Catch: \(error)")
         }
         
 //        allItems = mainEntity?.sharedEntites ?? [SharedEntity]()
     }
 }

 #Preview {
     
     do {
         let config = ModelConfiguration(isStoredInMemoryOnly: true)
         let container = try ModelContainer(for: SecondaryEntity.self, configurations: config)
         
         return MultiSelectPickerView(mainEntityID: MainEntity(displayName: "Example").persistentModelID, in: container, selectedItems: .constant([SharedEntity]()))
     } catch {
         fatalError("Failed to create model container.")
     }
 }

 
 */
