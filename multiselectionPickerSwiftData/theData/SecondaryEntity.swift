//
//  SecondaryEntity.swift
//  multiselectionPickerSwiftData
//
//  Created by Kyra on 12/30/23.
//

import Foundation
import SwiftData

@Model
class SecondaryEntity {
    var displayName: String = ""
    
    // Relationships
    var mainEntity: MainEntity?
    @Relationship(deleteRule: .nullify, inverse: \SharedEntity.secondaryEntites) var sharedEnties: [SharedEntity]?
    
    init(displayName: String = "", mainEntity: MainEntity? = nil, sharedEnties: [SharedEntity]? = [SharedEntity]()) {
        self.displayName = displayName
        self.mainEntity = mainEntity
        self.sharedEnties = sharedEnties
    }
}
