/*
 BarGraphView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

struct BarGraphView: View {
    var value: Double

    var body: some View {
        Rectangle()
            .frame(width: 120, height: 8)
            .foregroundStyle(Color.clear)
            .border(Color.accentColor, width: 0.5)
            .overlay(alignment: .leading) {
                Rectangle()
                    .frame(width: 120 * min(100, value) / 100, height: 8)
                    .foregroundStyle(Color.accentColor)
            }
    }
}
