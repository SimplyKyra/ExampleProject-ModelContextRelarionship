//
//  MainEntity.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra on 12/30/23.
//

import Foundation
import SwiftData

@Model
class MainEntity {
    var displayName: String = ""
    
    // Relationships
    @Relationship(deleteRule: .cascade, inverse: \SharedEntity.mainEntity) var sharedEntites: [SharedEntity]?
    @Relationship(deleteRule: .cascade, inverse: \SecondaryEntity.mainEntity) var secondaryEntities: [SecondaryEntity]?
    
    init(displayName: String = "", sharedEntites: [SharedEntity]? = nil, secondaryEntities: [SecondaryEntity]? = nil) {
        self.displayName = displayName
        self.sharedEntites = sharedEntites
        self.secondaryEntities = secondaryEntities
    }
}
