/*
 SystemInfoBundle+Extension.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SystemInfoKit

extension SystemInfoBundle {
    public static func cpuZero() -> SystemInfoBundle {
        var bundle = SystemInfoBundle()
        bundle.cpuInfo = CPUInfo.zero
        return bundle
    }
}
