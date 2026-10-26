/*
 SegmentedButtonStyle.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/03.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

struct SegmentedButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            configuration.label
                .font(.body)
                .frame(width: 16, height: 16)
                .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .padding(4)
    }
}

extension PrimitiveButtonStyle where Self == SegmentedButtonStyle {
    static var segmented: SegmentedButtonStyle { .init() }
}
