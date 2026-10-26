/*
 CustomRunnerRowView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/07/28.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import SwiftUI

struct CustomRunnerRowView: View {
    var runnerBundle: RunnerBundle
    var deleteButtonTapped: () async -> Void

    var body: some View {
        LabeledContent {
            Button(role: .destructive) {
                Task {
                    await deleteButtonTapped()
                }
            } label: {
                Image(systemName: "minus.circle")
            }
            .buttonStyle(.borderless)
            .tint(Color.red)
        } label: {
            Label {
                Text(runnerBundle.runner.formatted)
            } icon: {
                runnerBundle.thumbnail
            }
        }
    }
}
