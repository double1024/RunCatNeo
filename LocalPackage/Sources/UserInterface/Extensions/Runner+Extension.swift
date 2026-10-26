/*
 Runner+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/10.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource

extension Runner {
    var formatted: String {
        switch source {
        case let .builtIn(kind):
            kind.localizedName
        case let .custom(name):
            name
        }
    }
}
