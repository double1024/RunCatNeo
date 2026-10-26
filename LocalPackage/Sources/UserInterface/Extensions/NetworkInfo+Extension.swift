/*
 NetworkInfo+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SystemInfoKit

extension NetworkInfo {
    func masked(_ masked: Bool) -> NetworkInfo {
        self.masked(with: "192.0.2.1", isEnabled: masked)
    }
}
