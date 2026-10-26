/*
 Percentage+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/25.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SystemInfoKit

extension Percentage {
    var menuBarDescription: String {
        String(
            format: value < 100 ? "%4.1f%%" : "%4.0f%%",
            locale: .current,
            value
        )
    }
}
