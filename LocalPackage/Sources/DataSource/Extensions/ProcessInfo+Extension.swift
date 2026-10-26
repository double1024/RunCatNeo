/*
 ProcessInfo+Extension.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

extension ProcessInfo {
    static var needsResetUserDefaults: Bool {
#if DEBUG
        Self.processInfo.arguments.contains("ResetUserDefaults")
#else
        false
#endif
    }

    static var needsShowAllData: Bool {
#if DEBUG
        Self.processInfo.arguments.contains("ShowAllData")
#else
        false
#endif
    }

    public static var isPreview: Bool {
#if DEBUG
        Self.processInfo.arguments.contains("IsPreview")
#else
        false
#endif
    }
}
