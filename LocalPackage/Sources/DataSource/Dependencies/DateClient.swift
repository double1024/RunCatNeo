/*
 DateClient.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct DateClient: DependencyClient {
    public var now: @Sendable () -> Date

    public static let liveValue = Self(
        now: { Date.now }
    )

    public static let testValue = Self(
        now: { Date.distantPast }
    )
}
