/*
 RunCatNeoApp.swift
 RunCatNeo

 Created by Takuto Nakamura on 2026/01/15.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI
import UserInterface

@main
struct RunCatNeoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @AppStorage(.showsMetricsBar) private var showsMetricsBar = false

    var body: some Scene {
        RunnerBarScene()
        MetricsBarScene(isInserted: $showsMetricsBar)
        SettingsWindowScene()
    }
}
