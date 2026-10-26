/*
 GuidanceView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/08/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

struct GuidanceView: View {
    var description: LocalizedStringKey

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(description, bundle: .module)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: 360, alignment: .leading)
    }
}
