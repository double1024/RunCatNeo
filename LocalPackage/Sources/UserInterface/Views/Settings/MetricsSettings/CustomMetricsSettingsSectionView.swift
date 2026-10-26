/*
 CustomMetricsSettingsSectionView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/07.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

struct CustomMetricsSettingsSectionView: View {
    @State var store: CustomMetricsSettings

    var body: some View {
        Section {
            List {
                ForEach(store.customMetricsSources) { source in
                    CustomMetricsSourceRowView(
                        source: source,
                        isErrorDetected: store.failedCustomMetricsSourceIDs.contains(source.id),
                        removeButtonTapped: {
                            await store.send(.removeCustomMetricsSourceButtonTapped(source.id))
                        },
                        sourceLinkTapped: {
                            await store.send(.customMetricsSourceLinkTapped(source))
                        }
                    )
                }
                .onMove { indexSet, offset in
                    Task {
                        await store.send(.customMetricsSourceRowMoved(indexSet, offset))
                    }
                }
            }
            .confirmationDialog(
                Text("removeCustomMetrics", bundle: .module),
                isPresented: $store.showingConfirmationDialog,
                presenting: store.pendingRemovalSourceID,
                actions: { sourceID in
                    Button(role: .destructive) {
                        Task {
                            await store.send(.removingCustomMetricsSourceConfirmed)
                        }
                    } label: {
                        Text("remove", bundle: .module)
                    }
                    Button(role: .cancel) {
                        Task {
                            await store.send(.removingCustomMetricsSourceCancelled)
                        }
                    } label: {
                        Text("cancel", bundle: .module)
                    }
                },
                message: { _ in
                    Text("customMetricsConfirmationMessage", bundle: .module)
                }
            )
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
                        await store.send(.addCustomMetricsSourceButtonTapped)
                    }
                } label: {
                    Label {
                        Text("addCustomMetricsSource", bundle: .module)
                    } icon: {
                        Image(systemName: "plus")
                    }
                }
                .fileImporter(
                    isPresented: $store.showingFileImporter,
                    allowedContentTypes: [.json],
                    allowsMultipleSelection: false,
                    onCompletion: { result in
                        Task {
                            await store.send(.fileImporterResponse(result))
                        }
                    }
                )
                .fileDialogMessage(Text("chooseJsonFile", bundle: .module))
                .fileDialogConfirmationLabel(Text("add", bundle: .module))
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
                        description: "customMetricsDescription"
                    )
                }
            }
        } header: {
            Text("customMetrics", bundle: .module)
        }
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
