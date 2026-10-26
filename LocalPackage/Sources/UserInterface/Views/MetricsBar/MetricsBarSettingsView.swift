/*
 MetricsBarSettingsView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/25.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI

struct MetricsBarSettingsView: View {
    @StateObject var store: MetricsBarSettings

    var body: some View {
        Form {
            Section {
                Toggle(isOn: Binding<Bool>(
                    get: { store.metricsBarConfiguration.showsCPU },
                    asyncSet: { await store.send(.showsSystemMetricsToggleSwitched(.cpu, $0)) }
                )) {
                    Text("showCPUUsage", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.metricsBarConfiguration.showsMemory },
                    asyncSet: { await store.send(.showsSystemMetricsToggleSwitched(.memory, $0)) }
                )) {
                    Text("showMemoryUsage", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.metricsBarConfiguration.showsStorage },
                    asyncSet: { await store.send(.showsSystemMetricsToggleSwitched(.storage, $0)) }
                )) {
                    Text("showStorageCapacity", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.metricsBarConfiguration.showsBattery },
                    asyncSet: { await store.send(.showsSystemMetricsToggleSwitched(.battery, $0)) }
                )) {
                    Text("showBatteryStatus", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.metricsBarConfiguration.showsNetwork },
                    asyncSet: { await store.send(.showsSystemMetricsToggleSwitched(.network, $0)) }
                )) {
                    Text("showNetworkConnectivity", bundle: .module)
                }
            } header: {
                Text("metricsBarSettings", bundle: .module)
            }
            if !store.customMetricsSources.isEmpty {
                Section {
                    ForEach(store.customMetricsSources) { source in
                        Toggle(isOn: Binding<Bool>(
                            get: { store.metricsBarConfiguration.showsCustomMetrics(of: source.id) },
                            asyncSet: { await store.send(.showsCustomMetricsToggleSwitched(source.id, $0)) }
                        )) {
                            Text("show\(source.displayName)Metrics", bundle: .module)
                        }
                    }
                } header: {
                    Text("customMetrics", bundle: .module)
                }
            }
        }
        .formStyle(.grouped)
        .frame(width: 360)
        .fixedSize()
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

extension MetricsBarSettings: ObservableObject {}
