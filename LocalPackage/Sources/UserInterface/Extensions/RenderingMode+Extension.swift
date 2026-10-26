/*
 RenderingMode+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource

extension RenderingMode {
    public var label: String {
        let localizationValue: String.LocalizationValue = switch self {
        case .monochrome:
            "monochrome"
        case .color:
            "color"
        }
        return String(localized: localizationValue, bundle: .module)
    }
}
