//
//  SharedEntity.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra on 12/30/23.
//

import Foundation
import SwiftData

@Model
class SharedEntity {
    var displayName: String = ""
    
    // Relationships
    var mainEntity: MainEntity?
    var secondaryEntities: [SecondaryEntity]?
    
    init(displayName: String = "", mainEntity: MainEntity? = nil, secondaryEntities: [SecondaryEntity]? = [SecondaryEntity]()) {
        self.displayName = displayName
        self.mainEntity = mainEntity
        self.secondaryEntities = secondaryEntities
    }
}
