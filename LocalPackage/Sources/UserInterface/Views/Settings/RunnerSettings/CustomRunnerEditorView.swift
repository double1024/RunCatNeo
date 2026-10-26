/*
 CustomRunnerEditorView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/03.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI

struct CustomRunnerEditorView: View {
    @Bindable var store: CustomRunnerEditor

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(text: $store.runnerName) {
                        Text("runnerName", bundle: .module)
                    }
                    .textFieldStyle(.roundedBorder)
                    Picker(selection: Binding<RenderingMode>(
                        get: { .init(isTemplate: store.isTemplate) },
                        asyncSet: { await store.send(.renderingModePickerSelected($0)) }
                    )) {
                        ForEach(RenderingMode.allCases) { mode in
                            Text(mode.label).tag(mode)
                        }
                    } label: {
                        Text("renderingMode", bundle: .module)
                    }
                    LabeledContent {
                        FrameImagesCollectionView(store: store)
                    } label: {
                        Text("frames", bundle: .module)
                        Text("requirements", bundle: .module)
                    }
                    LabeledContent {
                        RunnerPreviewView(store: store)
                    } label: {
                        Text("preview", bundle: .module)
                    }
                } header: {
                    Text("customRunnerEditor", bundle: .module)
                }
            }
            .formStyle(.grouped)
            .fixedSize()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        Task {
                            await store.send(.cancelButtonTapped)
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        Task {
                            await store.send(.addButtonTapped)
                        }
                    } label: {
                        Text("add", bundle: .module)
                    }
                    .disabled(!store.canAdd)
                }
            }
            .alert(
                isPresented: $store.showingAlert,
                error: store.error,
                actions: { _ in },
                message: { _ in }
            )
            .task {
                await store.send(.viewAppeared)
            }
            .onDisappear {
                Task {
                    await store.send(.viewDisappeared)
                }
            }
        }
    }
}
