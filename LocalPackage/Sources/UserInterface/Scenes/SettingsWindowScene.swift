/*
 SettingsWindowScene.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/23.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

public struct SettingsWindowScene: Scene {
    public init() {}

    public var body: some Scene {
        Settings {
            SettingsView()
                .windowResizeBehavior(.enabled)
                .windowResizeAnchor(.topLeading)
        }
    }
}
