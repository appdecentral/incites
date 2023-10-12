//
//  IncitesMigrationPlan.swift
//  Incites
//
//  Created by Drew McCormack on 10/10/2023.
//

import Foundation
import SwiftData

typealias CurrentVersionedSchema = IncitesSchema3

enum IncitesMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [IncitesSchema1.self, IncitesSchema2.self, IncitesSchema3.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3]
    }
    
    static let migrateV1toV2: MigrationStage = .lightweight(fromVersion: IncitesSchema1.self, toVersion: IncitesSchema2.self)
    static let migrateV2toV3: MigrationStage = .lightweight(fromVersion: IncitesSchema2.self, toVersion: IncitesSchema3.self)
}

