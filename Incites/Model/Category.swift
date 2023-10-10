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
    var id: String = ""
    var textLabel: String = ""
    var sortPriority: Int = 0
    var color: InciteColor = InciteColor.blue
    @Relationship(deleteRule: .nullify) var incites: [Incite]! = []
    init() {}
}
