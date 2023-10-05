//
//  Incite.swift
//  Incites
//
//  Created by Drew McCormack on 03/10/2023.
//

import Foundation
import SwiftData

enum Language: Codable {
    case english
    case spanish
    case german
    
    static var current: Language {
        return .english
    }
}

enum InciteColor: Codable {
    case red
    case green
    case blue
    case purple
}

struct Fact: Codable {
    var text: String
    var language: Language
    
    enum Representation: Codable {
        case text(Language)
        case image(UUID)
        case spoken(Language)
    }
}

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

@Model
final class InciteImage: Identifiable {
    @Attribute(.unique) let id: UUID
    @Attribute(.externalStorage) let imageData: Data
    init(imageData: Data, incite: Incite) {
        self.id = UUID()
        self.imageData = imageData
    }
}

@Model
final class Category: Identifiable {
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
