//
//  IncitesMigrationPlan.swift
//  Incites
//
//  Created by Drew McCormack on 10/10/2023.
//

import Foundation
import SwiftData

enum IncitesMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [IncitesSchema1.self, IncitesSchema2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2: MigrationStage = .lightweight(fromVersion: IncitesSchema1.self, toVersion: IncitesSchema2.self)
}

