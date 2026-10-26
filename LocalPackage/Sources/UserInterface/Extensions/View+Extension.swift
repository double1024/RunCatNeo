/*
 View+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

extension View {
    var isDebugBuild: Bool {
#if DEBUG
        true
#else
        false
#endif
    }

    @ViewBuilder
    func labelStyle(isReady: Bool) -> some View {
        if isReady {
            labelStyle(.iconOnly)
        } else {
            labelStyle(.titleAndIcon)
        }
    }
}
