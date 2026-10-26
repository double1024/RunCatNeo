/*
 GraphicsContext+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/25.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

extension GraphicsContext {
    mutating func drawBlackImage(origin: CGPoint, size: CGSize, @ViewBuilder image: () -> Image) {
        var resolvedImage = resolve(image())
        resolvedImage.shading = .color(.black)
        draw(resolvedImage, in: CGRect(origin: origin, size: size))
    }

    mutating func drawBlackText(origin: CGPoint, size: CGSize, @ViewBuilder text: () -> Text) {
        var resolvedText = resolve(text())
        resolvedText.shading = .color(.black)
        draw(resolvedText, in: CGRect(origin: origin, size: size))
    }

    mutating func drawIcon(systemName: String, point: CGPoint, size: CGSize) {
        var image = resolve(.init(systemName: systemName))
        image.shading = .color(.black)
        let point = CGPoint(
            x: point.x + 0.5 * size.width,
            y: point.y + 0.5 * size.height
        )
        draw(image, at: point, anchor: .center)
    }
}
