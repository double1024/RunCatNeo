/*
 GeneralSettingsView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/23.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI

struct GeneralSettingsView: View {
    @StateObject var store: GeneralSettings

    var body: some View {
        Form {
            Section {
                Toggle(isOn: Binding<Bool>(
                    get: { store.launchesAtLogin },
                    asyncSet: { await store.send(.launchAtLoginToggleSwitched($0)) }
                )) {
                    Text("launchAtLogin", bundle: .module)
                }
            } header: {
                Text("launch", bundle: .module)
            }
            Section {
                Picker(selection: Binding<UpdateInterval>(
                    get: { store.updateInterval },
                    asyncSet: { await store.send(.updateIntervalPickerSelected($0)) }
                )) {
                    ForEach(UpdateInterval.allCases) { interval in
                        Text("\(interval.seconds)seconds", bundle: .module)
                            .tag(interval)
                    }
                } label: {
                    Text("updateInterval", bundle: .module)
                }
            } header: {
                Text("monitoring", bundle: .module)
            }
        }
        .formStyle(.grouped)
        .task {
            await store.send(.viewAppeared(String(describing: Self.self)))
        }
    }
}

extension GeneralSettings: ObservableObject {}
