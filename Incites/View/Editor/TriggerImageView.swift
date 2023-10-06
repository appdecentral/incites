//
//  TriggerImageView.swift
//  Incites
//
//  Created by Drew McCormack on 06/10/2023.
//

import SwiftUI
import SwiftData
import UIKit

struct TriggerImageView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var incite: Incite
    
    private static let availableImageNames = ["Tree", "Car", "Earth"]
    
    var body: some View {
        Text("Trigger Image")
            .font(.title2.weight(.light))
            .padding(.top, 30)
        if case let .image(imageId) = incite.prompt {
            Image(data: incite.dataForImage(withId: imageId))!
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 100, maxHeight: 100)
            Text("Other Choices")
                .font(.headline.weight(.light))
                .padding(.top, 30)
        }
        HStack {
            ForEach(Self.availableImageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, maxHeight: 100)
                    .onTapGesture {
                        withAnimation {
                            let data = UIImage(named: imageName)!.pngData()!
                            let inciteImage = InciteImage(imageData: data)
                            modelContext.insert(inciteImage)
                            inciteImage.incite = incite
                            incite.prompt = .image(inciteImage.id)
                        }
                    }
            }
        }
    }
}

extension Incite {
    
    func dataForImage(withId imageId: UUID) -> Data {
        let inciteImage = images.first(where: { $0.id == imageId })!
        return inciteImage.imageData
    }
    
}

extension Image {
    
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self = .init(uiImage: image)
    }
    
}

