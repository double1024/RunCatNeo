/*
 MetricsSettingsView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/23.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

struct MetricsSettingsView: View {
    @StateObject var store: MetricsSettings

    var body: some View {
        Form {
            Section {
                Toggle(isOn: Binding<Bool>(
                    get: { store.showsMetricsBar },
                    asyncSet: { await store.send(.showMetricsBarToggleSwitched($0)) }
                )) {
                    Text("showMetricsBar", bundle: .module)
                }
                .sheet(isPresented: $store.showingMetricsBarNotesSheet) {
                    MetricsBarNotesView(store: store)
                }
            } header: {
                Text("metricsBar", bundle: .module)
            }
            Section {
                Toggle(isOn: Binding<Bool>(
                    get: { store.systemMetricsConfiguration.monitorsMemory },
                    asyncSet: { await store.send(.monitorsSystemMetricsToggleSwitched(.memory, $0)) }
                )) {
                    Text("enableMemoryUsageMonitoring", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.systemMetricsConfiguration.monitorsStorage },
                    asyncSet: { await store.send(.monitorsSystemMetricsToggleSwitched(.storage, $0)) }
                )) {
                    Text("enableStorageCapacityMonitoring", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.systemMetricsConfiguration.monitorsBattery },
                    asyncSet: { await store.send(.monitorsSystemMetricsToggleSwitched(.battery, $0)) }
                )) {
                    Text("enableBatteryStatusMonitoring", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.systemMetricsConfiguration.monitorsNetwork },
                    asyncSet: { await store.send(.monitorsSystemMetricsToggleSwitched(.network, $0)) }
                )) {
                    Text("enableNetworkConnectivityMonitoring", bundle: .module)
                }
            } header: {
                Text("systemMetrics", bundle: .module)
            }
            CustomMetricsSettingsSectionView(store: store.customMetricsSettings)
        }
        .formStyle(.grouped)
        .task {
            await store.send(.viewAppeared(String(describing: Self.self)))
        }
        .onDisappear {
            Task {
                await store.send(.viewDisappeared)
            }
        }
    }
}

extension MetricsSettings: ObservableObject {}
