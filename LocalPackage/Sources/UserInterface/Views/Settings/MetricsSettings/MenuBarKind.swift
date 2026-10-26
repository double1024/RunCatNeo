/*
 MenuBarKind.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/10.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

enum MenuBarKind {
    case withNotch
    case withoutNotch

    var borderColor: Color {
        switch self {
        case .withNotch:
            Color.red
        case .withoutNotch:
            Color.green
        }
    }
}
