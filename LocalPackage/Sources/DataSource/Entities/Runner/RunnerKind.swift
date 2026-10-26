/*
 RunnerKind.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public enum RunnerKind: String, Sendable, Identifiable, CaseIterable {
    case cat = "cat"
    case dog = "dog"
    case slime = "slime"
    case drop = "drop"
    case coffee = "coffee"
    case newtonCradle = "newton-cradle"
    case engine = "engine"
    case mochi = "mochi"

    public var id: String { rawValue }

    var numberOfResources: Int {
        switch self {
        case .cat: 5
        case .dog: 5
        case .slime: 5
        case .drop: 5
        case .coffee: 10
        case .newtonCradle: 5
        case .engine: 10
        case .mochi: 5
        }
    }

    var frameOrder: FrameOrder {
        let n = numberOfResources
        return switch self {
        case .cat: .ascending(n)
        case .dog: .ascending(n)
        case .slime: .partyHorn
        case .drop: .ascending(n)
        case .coffee: .ascending(n)
        case .newtonCradle: .pendulum
        case .engine: .ascending(n)
        case .mochi: .swing
        }
    }
}
