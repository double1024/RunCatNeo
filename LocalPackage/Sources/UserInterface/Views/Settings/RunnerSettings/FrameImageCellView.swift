/*
 FrameImageCellView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/03.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import SwiftUI

struct FrameImageCellView: View {
    var index: Int
    var frameImage: FrameImage
    var isTemplate: Bool
    var isSelected: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(frameImage.cgImage, scale: 1.0, label: Text("frame\(index)", bundle: .module))
                .renderingMode(isTemplate ? .template : .original)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(verbatim: "\(index)")
                .font(.caption)
        }
        .border(isSelected ? Color.accentColor : Color.clear)
        .padding(4)
        .contentShape(.rect)
    }
}
