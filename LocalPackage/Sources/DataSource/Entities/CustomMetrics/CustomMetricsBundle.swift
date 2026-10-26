/*
 CustomMetricsBundle.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct CustomMetricsBundle: Sendable, Identifiable, Equatable {
    public var id: UUID
    public var snapshot: CustomMetricsSnapshot
    public var isFailed: Bool

    public init(
        id: UUID,
        snapshot: CustomMetricsSnapshot,
        isFailed: Bool = false
    ) {
        self.id = id
        self.snapshot = snapshot
        self.isFailed = isFailed
    }
}
