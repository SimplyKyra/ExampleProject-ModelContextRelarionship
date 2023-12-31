//
//  SecondaryTab.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra Delaney on 12/31/23.
//

import SwiftUI
import SwiftData

struct SecondTab: View {
    
    @Query(sort: \MainEntity.displayName, order: .forward) var allMainEntities: [MainEntity]
    @State var selectedEntity: MainEntity? = nil
    
    var body: some View {
        VStack {
            HStack {
//                Text("Select Main Entity:")
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
            }
            
            Text("Asociated shared entities")
        }
    }
}

#Preview {
    SecondTab()
}
