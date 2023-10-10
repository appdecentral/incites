//
//  Incite.swift
//  Incites
//
//  Created by Drew McCormack on 06/10/2023.
//

import Foundation
import SwiftData

@Model
final class Incite: Identifiable {
    let id: UUID = UUID.init()
    let creationDate: Date = Date.now
    var fact: Fact = Fact.init(text: "", language: .english)
    var prompt: Fact.Representation = Fact.Representation.text(.spanish)
    var response: Fact.Representation = Fact.Representation.text(.english)
    @Relationship(deleteRule: .cascade) var images: [InciteImage]! = []
    @Relationship(deleteRule: .nullify, minimumModelCount: 1, inverse: \Category.incites) var categories: [Category]! = []
    init() {}
}
