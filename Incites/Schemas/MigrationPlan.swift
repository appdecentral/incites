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
    static let migrateV2toV3: MigrationStage = .custom(fromVersion: IncitesSchema2.self, toVersion: IncitesSchema3.self, 
        willMigrate: nil,
        didMigrate: { context in
            let categories = try context.fetch(FetchDescriptor<IncitesSchema3.Category>())
            for category in categories {
                if category.oldId == "ALL" {
                    category.varietyString = Category.Variety.allIncites.rawValue
                } else if let uuid = UUID(uuidString: category.oldId) {
                    category.uniqueId = uuid
                }
            }
            try! context.save()
        })

}

