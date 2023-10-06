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
    static let allId = "ALL"
    
    @Attribute(.unique) let id: String
    @Attribute(.spotlight) var textLabel: String
    var sortPriority: Int
    var color: InciteColor
    @Relationship(deleteRule: .nullify) var incites: [Incite]
    
    init(id: String?) {
        self.id = id != nil ? id! : UUID().uuidString
        self.textLabel = ""
        self.color = .blue
        self.sortPriority = 0
        self.incites = []
    }
}
