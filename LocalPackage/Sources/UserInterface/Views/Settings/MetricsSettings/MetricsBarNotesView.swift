/*
 MetricsBarNotesView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/10.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

struct MetricsBarNotesView: View {
    var store: MetricsSettings

    var body: some View {
        VStack(spacing: 16) {
            Image(nsImage: NSImage.appIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            VStack(spacing: 8) {
                Text("notesOnUsingMetricsBar", bundle: .module)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Text("metricsBarNotes", bundle: .module)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            VStack(spacing: 8) {
                MenuBarSampleView(kind: .withoutNotch)
                MenuBarSampleView(kind: .withNotch)
                Button {
                    Task {
                        await store.send(.changedMyMindButtonTapped)
                    }
                } label: {
                    Text("changedMyMind", bundle: .module)
                        .frame(maxWidth: .infinity)
                }
                .keyboardShortcut(.defaultAction)
                .controlSize(.large)
                Button(role: .cancel) {
                    Task {
                        await store.send(.showButtonTapped)
                    }
                } label: {
                    Text("show", bundle: .module)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
        .frame(width: 320)
        .padding(16)
    }
}
