//
//  Insight.swift
//  Insights
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

enum InsightColor: Codable {
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
final class InsightImage {
    @Attribute(.externalStorage) let imageData: Data
    let insight: Insight
    init(imageData: Data, insight: Insight) {
        self.imageData = imageData
        self.insight = insight
    }
}

@Model
final class Tag {
    @Attribute(.spotlight) var textLabel: String
    var color: InsightColor
    
    init() {
        self.textLabel = ""
        self.color = .blue
    }
}

@Model
final class Insight {
    let creationDate: Date
    @Attribute(.spotlight) var fact: Fact
    var prompt: Fact.Representation
    var response: Fact.Representation
    @Relationship(deleteRule: .cascade) var images: [InsightImage]
    var tags: [Tag]
    
    init() {
        self.creationDate = Date.now
        self.prompt = .text(.spanish)
        self.response = .text(.english)
        self.fact = Fact(text: "", language: .current)
        self.images = []
        self.tags = []
    }
}
