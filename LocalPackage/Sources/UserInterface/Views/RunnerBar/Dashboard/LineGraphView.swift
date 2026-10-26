/*
 LineGraphView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

struct LineGraphView: View {
    var values: [Double]

    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 16))
            values.enumerated().forEach { offset, value in
                let v = min(100, max(2, value))
                path.addLine(to: CGPoint(x: 2.0 * CGFloat(offset), y: 16 - 0.16 * v))
            }
            path.addLine(to: CGPoint(x: 120, y: 16))
            path.closeSubpath()
        }
        .fill(Color.accentColor)
        .frame(width: 120, height: 16)
    }
}
