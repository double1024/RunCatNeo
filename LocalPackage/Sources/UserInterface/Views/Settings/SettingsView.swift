/*
 SettingsView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/23.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI

struct SettingsView: View {
    @Environment(\.appDependencies) private var appDependencies
    @State private var settingsTab = SettingsTab.general

    var body: some View {
        TabView(selection: $settingsTab.animation()) {
            GeneralSettingsView(store: .init(appDependencies))
                .tabItem {
                    Label {
                        Text("generalTab", bundle: .module)
                    } icon: {
                        Image(systemName: "gear")
                    }
                }
                .tag(SettingsTab.general)
            RunnerSettingsView(store: .init(appDependencies))
                .tabItem {
                    Label {
                        Text("runnerTab", bundle: .module)
                    } icon: {
                        Image(.runcat)
                    }
                }
                .tag(SettingsTab.runner)
            MetricsSettingsView(store: .init(appDependencies))
                .tabItem {
                    Label {
                        Text("metricsTab", bundle: .module)
                    } icon: {
                        Image(systemName: "chart.bar.horizontal.page.fill")
                    }
                }
                .tag(SettingsTab.metrics)
        }
        .fixedSize()
        .accessibilityIdentifier("settings")
    }
}
