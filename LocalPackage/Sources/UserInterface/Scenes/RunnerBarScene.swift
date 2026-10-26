/*
 RunnerBarScene.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

public struct RunnerBarScene: Scene {
    @Environment(\.appDependencies) private var appDependencies

    public init() {}

    public var body: some Scene {
        MenuBarExtra {
            DashboardView(store: .init(appDependencies))
        } label: {
            RunnerBarView(store: .init(appDependencies))
        }
        .menuBarExtraStyle(.window)
    }
}
