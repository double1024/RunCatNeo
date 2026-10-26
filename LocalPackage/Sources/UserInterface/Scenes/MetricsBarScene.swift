/*
 MetricsBarScene.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/24.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

public struct MetricsBarScene: Scene {
    @Environment(\.appDependencies) private var appDependencies
    @Binding private var isInserted: Bool

    public init(isInserted: Binding<Bool>) {
        _isInserted = isInserted
    }

    public var body: some Scene {
        MenuBarExtra(isInserted: $isInserted) {
            MetricsBarSettingsView(store: .init(appDependencies))
        } label: {
            MetricsBarView(store: .init(appDependencies))
        }
        .menuBarExtraStyle(.window)
    }
}
