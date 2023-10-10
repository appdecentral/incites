//
//  Schema1.swift
//  Incites
//
//  Created by Drew McCormack on 10/10/2023.
//

import Foundation
import SwiftData

enum IncitesSchema1: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Incite.self, InciteImage.self, Category.self]
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
        @Relationship(inverse: \Incite.images) var incite: Incite?
        init(imageData: Data) {
            self.id = UUID()
            self.imageData = imageData
            self.incite = nil
        }
    }

}
