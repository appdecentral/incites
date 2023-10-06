//
//  CodableTypes.swift
//  Incites
//
//  Created by Drew McCormack on 06/10/2023.
//

import Foundation
import SwiftUI

enum Language: String, Codable {
    case english
    case spanish
    case german
    
    static var current: Language {
        return .english
    }
}

enum InciteColor: String, Codable {
    case black
    case red
    case green
    case blue
    case purple
    
    var color: Color {
        switch self {
        case .black:
            return .black
        case .blue:
            return .blue
        case .green:
            return .green
        case .purple:
            return .purple
        case .red:
            return .red
        }
    }
    
    static var random: InciteColor {
        [Self.blue, .green, .purple, .red].randomElement()!
    }
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
