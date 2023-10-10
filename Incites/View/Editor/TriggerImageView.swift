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
        let prompt = incite.prompt
        if case let .image(imageId) = prompt {
            Text("Trigger Image")
                .font(.title2.weight(.light))
                .padding(.top, 30)
            Image(data: incite.dataForImage(withId: imageId))!
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 160, maxHeight: 160)
            Text("Download Other...")
                .font(.headline.weight(.light))
                .padding(.top, 30)
        } else {
            Text("Choose Trigger Image")
                .font(.title2.weight(.light))
                .padding(.top, 30)
        }
        HStack {
            Spacer()
            ForEach(Self.availableImageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 60, maxHeight: 60)
                    .onTapGesture {
                        withAnimation {
                            let data = UIImage(named: imageName)!.pngData()!
                            let inciteImage = InciteImage()
                            inciteImage.imageData = data
                            modelContext.insert(inciteImage)
                            inciteImage.incite = incite
                            incite.prompt = .image(inciteImage.id)
                        }
                    }
            }
            Spacer()
        }
    }
}

extension Incite {
    
    func dataForImage(withId imageId: UUID) -> Data {
        guard let images else { return Data() }
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

