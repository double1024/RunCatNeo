/*
 RenderingMode.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public enum RenderingMode: Hashable, Sendable, Identifiable, CaseIterable {
    case monochrome
    case color

    public var id: Self { self }

    public init(isTemplate: Bool) {
        self = isTemplate ? .monochrome : .color
    }

    public var isTemplate: Bool {
        switch self {
        case .monochrome:
            true
        case .color:
            false
        }
    }
}
