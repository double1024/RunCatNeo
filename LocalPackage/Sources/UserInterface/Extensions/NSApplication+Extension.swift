/*
 NSApplication+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AppKit

extension NSApplication {
    func statusBarButton(withTitle: String) -> NSStatusBarButton? {
        NSApp.windows
            .compactMap { window -> NSStatusBarButton? in
                guard let view = window.contentView?.subviews.first,
                      let statusBarButton = view.subviews.first as? NSStatusBarButton else {
                    return nil
                }
                return statusBarButton
            }
            .first { $0.title == "\0" }
    }
}
