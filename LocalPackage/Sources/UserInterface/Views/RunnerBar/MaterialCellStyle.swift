/*
 MaterialCellStyle.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

private struct MaterialCellViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color(.separatorColor), lineWidth: 1)
            }
            .compositingGroup()
            .shadow(radius: 2, y: 2)
    }
}

extension View {
    func materialCellStyle() -> some View {
        modifier(MaterialCellViewModifier())
    }
}
