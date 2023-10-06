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
    @Attribute(.unique) let id: UUID
    let creationDate: Date
    var fact: Fact
    var prompt: Fact.Representation
    var response: Fact.Representation
    @Relationship(deleteRule: .cascade) var images: [InciteImage]
    @Relationship(deleteRule: .nullify, minimumModelCount: 1, inverse: \Category.incites) var categories: [Category]
    
    init() {
        self.id = UUID()
        self.creationDate = Date.now
        self.prompt = .text(.spanish)
        self.response = .text(.english)
        self.fact = Fact(text: "", language: .current)
        self.images = []
        self.categories = []
    }
}
