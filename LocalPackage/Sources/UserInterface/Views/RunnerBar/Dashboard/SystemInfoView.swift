/*
 SystemInfoView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI
import SystemInfoKit

struct SystemInfoView<Accessory: View>: View {
    var systemInfo: any SystemInfo
    var isVisibleDetails = true
    @ViewBuilder var accessory: () -> Accessory

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: systemInfo.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(verbatim: systemInfo.summary)
                Group {
                    if isVisibleDetails {
                        ForEach(systemInfo.details.indices, id: \.self) { index in
                            Text(verbatim: systemInfo.details[index])
                                .font(.caption)
                        }
                    }
                    accessory()
                }
                .padding(.leading, 12)
            }
        }
        .fixedSize()
        .padding(.leading, 8)
    }
}
