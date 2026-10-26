/*
 RunnerKind+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/10.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource

extension RunnerKind {
    var localizedName: String {
        switch self {
        case .cat:
            String(localized: "cat", table: "RunnerNames", bundle: .module)
        case .dog:
            String(localized: "dog", table: "RunnerNames", bundle: .module)
        case .slime:
            String(localized: "slime", table: "RunnerNames", bundle: .module)
        case .drop:
            String(localized: "drop", table: "RunnerNames", bundle: .module)
        case .coffee:
            String(localized: "coffee", table: "RunnerNames", bundle: .module)
        case .newtonCradle:
            String(localized: "newtonCradle", table: "RunnerNames", bundle: .module)
        case .engine:
            String(localized: "engine", table: "RunnerNames", bundle: .module)
        case .mochi:
            String(localized: "mochi", table: "RunnerNames", bundle: .module)
        }
    }
}
