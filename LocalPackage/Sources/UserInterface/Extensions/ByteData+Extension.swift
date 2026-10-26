/*
 ByteData+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/25.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SystemInfoKit

extension ByteData {
    func menuBarDescription(type: SystemInfoType) -> String {
        let (value, unit) = readableValue
        return switch type {
        case .storage:
            String(format: "%5.2f %@", locale: .current, value, unit)
        case .network:
            String(format: value < 100 ? "%4.1f %@/s" : "%4.0f %@/s", locale: .current, value, unit)
        default:
            description
        }
    }
}
