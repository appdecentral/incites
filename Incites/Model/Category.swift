//
//  Incite.swift
//  Incites
//
//  Created by Drew McCormack on 03/10/2023.
//

import Foundation
import SwiftData

@Model
final class Category: Identifiable {
    enum Variety: String {
        case userCreated
        case allIncites
    }
    
    var id: String = "" // Deprecated
    var uniqueId: UUID = UUID.init()
    
    var varietyString: String = Variety.userCreated.rawValue
    var variety: Variety {
        get {
            Variety(rawValue: varietyString)!
        }
        set {
            varietyString = newValue.rawValue
        }
    }
    
    var textLabel: String = ""
    var sortPriority: Int = 0
    var color: InciteColor = InciteColor.blue
    @Relationship(deleteRule: .nullify) var incites: [Incite]! = []
    
    init() {}
}

extension ModelContext {
    var allInsitesCategory: Category {
        allInsitesCategories.first!
    }
    
    private var allInsitesCategories: [Category] {
        let string = Category.Variety.allIncites.rawValue
        let descriptor = FetchDescriptor<Category>(predicate: #Predicate { $0.varietyString == string })
        return try! fetch(descriptor)
    }
    
    func deduplicateCategories() {
        // Merge the "All Incites" categories, so there is only one.
        // We sort to make sure that each device keeps the same object
        let alls: [Category] = allInsitesCategories.sorted(by: { $0.id < $1.id })
        let toKeep = alls.first!
        let others = alls.dropFirst()
        for other in others {
            toKeep.incites.append(contentsOf: other.incites)
            delete(other)
        }
    }
}
