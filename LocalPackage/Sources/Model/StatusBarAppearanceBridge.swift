/*
 StatusBarAppearanceBridge.swift
 Model

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AllocatedUnfairLock
import AppKit
import DataSource

public final class StatusBarAppearanceBridge: Sendable {
    public static let shared = StatusBarAppearanceBridge()

    private let lockedStreamBundle = AllocatedUnfairLock<AsyncStreamBundle<NSAppearance>>(initialState: .init())

    public var stream: any AsyncShareStream<NSAppearance> {
        lockedStreamBundle.withLock(\.stream)
    }

    public func send(_ appearance: NSAppearance) {
        guard appearance != lockedStreamBundle.withLock(\.latestValue) else { return }
        lockedStreamBundle.withLock { $0.send(appearance) }
    }
}

extension NSAppearance: @retroactive @unchecked Sendable {}
