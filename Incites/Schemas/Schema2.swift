//
//  Schema2.swift
//  Incites
//
//  Created by Drew McCormack on 10/10/2023.
//

import Foundation
import SwiftData

enum IncitesSchema2: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(1, 1, 0)
    
    static var models: [any PersistentModel.Type] {
        [Incite.self, InciteImage.self, Category.self]
    }
    
    @Model
    final class Category: Identifiable {
        let id: String = ""
        var textLabel: String = ""
        var sortPriority: Int = 0
        var color: InciteColor = InciteColor.blue
        @Relationship(deleteRule: .nullify) var incites: [Incite]! = []
        init() {}
    }

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

    @Model
    final class InciteImage: Identifiable {
        let id: UUID = UUID.init()
        @Attribute(.externalStorage) let imageData: Data = Data()
        @Relationship(inverse: \Incite.images) var incite: Incite?
        init() {}
    }

}
