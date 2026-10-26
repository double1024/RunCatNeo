/*
 NSStatusBarButton+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AppKit
import Model

extension NSStatusBarButton {
    open override func viewDidChangeEffectiveAppearance() {
        super.viewDidChangeEffectiveAppearance()
        guard tag == .zero, let window else { return }
        StatusBarAppearanceBridge.shared.send(window.effectiveAppearance)
    }
}
