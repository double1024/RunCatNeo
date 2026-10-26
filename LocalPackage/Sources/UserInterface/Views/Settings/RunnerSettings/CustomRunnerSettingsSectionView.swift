/*
 CustomRunnerSettingsSectionView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/31.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

struct CustomRunnerSettingsSectionView: View {
    @State var store: CustomRunnerSettings

    var body: some View {
        Section {
            List {
                ForEach(store.customRunnerBundleList) { runnerBundle in
                    CustomRunnerRowView(
                        runnerBundle: runnerBundle,
                        deleteButtonTapped: {
                            await store.send(.deleteButtonTapped(runnerBundle.runner))
                        }
                    )
                }
                .onMove { indexSet, offset in
                    Task {
                        await store.send(.customRunnerRowMoved(indexSet, offset))
                    }
                }
            }
            .alert(
                isPresented: $store.showingAlert,
                error: store.error,
                actions: { _ in },
                message: { _ in }
            )
            HStack {
                Spacer()
                Button {
                    Task {
                        await store.send(.addCustomRunnerButtonTapped)
                    }
                } label: {
                    Label {
                        Text("addCustomRunner", bundle: .module)
                    } icon: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(item: $store.customRunnerEditor) { store in
                    CustomRunnerEditorView(store: store)
                }
                Button {
                    Task {
                        await store.send(.guidanceButtonTapped)
                    }
                } label: {
                    Label {
                        Text("guidance", bundle: .module)
                    } icon: {
                        Image(systemName: "info.circle")
                    }
                    .labelStyle(.iconOnly)
                }
                .buttonStyle(.borderless)
                .popover(isPresented: $store.showingGuidancePopover, arrowEdge: .bottom) {
                    GuidanceView(
                        description: "runnerGalleryDescription"
                    )
                }
            }
        } header: {
            Text("customRunners", bundle: .module)
        }
        .task {
            await store.send(.viewAppeared)
        }
    }
}
