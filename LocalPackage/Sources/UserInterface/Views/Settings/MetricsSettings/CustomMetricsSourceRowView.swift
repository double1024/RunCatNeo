/*
 CustomMetricsSourceRowView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import SwiftUI

struct CustomMetricsSourceRowView: View {
    var source: CustomMetricsSource
    var isErrorDetected: Bool
    var removeButtonTapped: () async -> Void
    var sourceLinkTapped: () async -> Void

    var body: some View {
        LabeledContent {
            Button(role: .destructive) {
                Task {
                    await removeButtonTapped()
                }
            } label: {
                Image(systemName: "minus.circle")
            }
            .buttonStyle(.borderless)
            .tint(Color.red)
        } label: {
            Text(source.displayName)
                .truncationMode(.middle)
            HStack(spacing: 8) {
                Text(LocalizedStringKey(stringLiteral: "\(source.fileURL.relativePath) [→](/)"))
                    .environment(\.openURL, OpenURLAction { _ in
                        Task {
                            await sourceLinkTapped()
                        }
                        return .handled
                    })
                if isErrorDetected {
                    Text("errorDetected", bundle: .module)
                        .foregroundStyle(Color.yellow)
                }
            }
        }
    }
}
