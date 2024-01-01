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
    @Relationship(deleteRule: .cascade, inverse: \SharedEntity.mainEntity) var sharedEntities: [SharedEntity]?
    @Relationship(deleteRule: .cascade, inverse: \SecondaryEntity.mainEntity) var secondaryEntities: [SecondaryEntity]?
    
    init(displayName: String = "", sharedEntites: [SharedEntity]? = [SharedEntity](), secondaryEntities: [SecondaryEntity]? = [SecondaryEntity]()) {
        self.displayName = displayName
        self.sharedEntities = sharedEntities
        self.secondaryEntities = secondaryEntities
    }
}
