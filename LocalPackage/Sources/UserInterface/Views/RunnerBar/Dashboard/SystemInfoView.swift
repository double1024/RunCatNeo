/*
 SystemInfoView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI
import SystemInfoKit

struct SystemInfoView: View {
    var systemInfo: any SystemInfo
    var iconName: String? = nil
    var isVisibleDetails = true
    var detailStrings: [String]? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName ?? systemInfo.icon)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(.secondary)
                .frame(width: 24, height: 22)
            VStack(alignment: .leading, spacing: 4) {
                Text(verbatim: systemInfo.summary)
                    .font(.system(.body, weight: .semibold))
                if isVisibleDetails {
                    ForEach(Array((detailStrings ?? systemInfo.details).enumerated()), id: \.offset) { _, detail in
                        Text(verbatim: detail)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .fixedSize()
    }
}
