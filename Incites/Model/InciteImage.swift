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
    @Attribute(.unique) let id: UUID
    @Attribute(.externalStorage) let imageData: Data
    @Relationship(inverse: \Incite.images) let incite: Incite
    init(imageData: Data, incite: Incite) {
        self.id = UUID()
        self.imageData = imageData
        self.incite = incite
    }
}
