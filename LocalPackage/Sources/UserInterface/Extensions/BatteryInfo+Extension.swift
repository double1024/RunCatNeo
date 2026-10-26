/*
 BatteryInfo+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/13.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SystemInfoKit

extension BatteryInfo {
    func simulated(_ simulated: Bool) -> BatteryInfo {
        self.simulated(
            with: .init(
                percentage: .init(rawValue: 0.746),
                maxCapacity: .init(rawValue: 0.937),
                cycleCount: 18,
                temperature: .init(value: 30.3)
            ),
            isEnabled: simulated
        )
    }
}
