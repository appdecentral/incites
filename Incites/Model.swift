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
final class InciteImage {
    @Attribute(.externalStorage) let imageData: Data
    @Attribute(.unique) let uuid: UUID
    let incite: Incite
    init(imageData: Data, incite: Incite) {
        self.imageData = imageData
        self.incite = incite
        self.uuid = UUID()
    }
}

@Model
final class Tag {
    @Attribute(.spotlight) var textLabel: String
    var color: InciteColor
    @Relationship(deleteRule: .nullify) var incites: [Incite]
    
    init() {
        self.textLabel = ""
        self.color = .blue
        self.incites = []
    }
}

@Model
final class Incite {
    let creationDate: Date
    @Attribute(.spotlight) var fact: Fact
    var prompt: Fact.Representation
    var response: Fact.Representation
    @Relationship(deleteRule: .cascade, inverse: \InciteImage.incite) var images: [InciteImage]
    @Relationship(deleteRule: .nullify, inverse: \Tag.incites) var tags: [Tag]
    
    init() {
        self.creationDate = Date.now
        self.prompt = .text(.spanish)
        self.response = .text(.english)
        self.fact = Fact(text: "", language: .current)
        self.images = []
        self.tags = []
    }
}
