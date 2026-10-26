/*
 RunnerSettingsView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

struct RunnerSettingsView: View {
    @State var store: RunnerSettings

    var body: some View {
        Form {
            Section {
                Toggle(isOn: Binding<Bool>(
                    get: { store.speedDecreasesUnderLoad },
                    asyncSet: { await store.send(.slowDownUnderLoadToggleSwitched($0)) }
                )) {
                    Text("slowDownUnderLoad", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.isFlippedHorizontally },
                    asyncSet: { await store.send(.flipHorizontallyToggleSwitched($0)) }
                )) {
                    Text("flipHorizontally", bundle: .module)
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.tintsBuiltInRunnerWithAccentColor },
                    asyncSet: { await store.send(.tintBuiltInRunnerWithAccentColorToggleSwitched($0)) }
                )) {
                    Text("tintBuiltInRunnerWithAccentColor", bundle: .module)
                }
            } header: {
                Text("appearance", bundle: .module)
            }
            CustomRunnerSettingsSectionView(store: store.customRunnerSettings)
        }
        .formStyle(.grouped)
        .task {
            await store.send(.viewAppeared(String(describing: Self.self)))
        }
    }
}
