//
//  Incite.swift
//  Incites
//
//  Created by Drew McCormack on 03/10/2023.
//

import Foundation
import SwiftData

typealias Category = CurrentVersionedSchema.Category

extension ModelContext {
    var allInsitesCategory: Category? {
        allInsitesCategories.first
    }
    
    private var allInsitesCategories: [Category] {
        let string = Category.Variety.allIncites.rawValue
        let descriptor = FetchDescriptor<Category>(predicate: #Predicate { $0.varietyString == string })
        return try! fetch(descriptor)
    }
    
    func migrateCategoriesToUniqueId() {
        let categories = try! fetch(FetchDescriptor<Category>())
        for category in categories {
            if category.id == "ALL" {
                category.varietyString = Category.Variety.allIncites.rawValue
            } else if let uuid = UUID(uuidString: category.id) {
                category.uniqueId = uuid
            }
            category.id = ""
        }
    }
    
    func deduplicateCategories() {
        // Merge the "All Incites" categories, so there is only one.
        // We sort to make sure that each device keeps the same object
        let alls: [Category] = allInsitesCategories.sorted(by: { $0.uniqueId < $1.uniqueId })
        let toKeep = alls.first!
        let others = alls.dropFirst()
        for other in others {
            toKeep.incites.append(contentsOf: other.incites)
            delete(other)
        }
    }
}
