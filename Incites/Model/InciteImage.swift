//
//  InciteImage.swift
//  Incites
//
//  Created by Drew McCormack on 06/10/2023.
//

import Foundation
import SwiftData

@Model
final class InciteImage: Identifiable {
    let id: UUID = UUID.init()
    @Attribute(.externalStorage) var imageData: Data = Data()
    @Relationship(inverse: \Incite.images) var incite: Incite?
    init() {}
}
