/*
 MetricsBarConfiguration.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/24.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct MetricsBarConfiguration: Codable, Sendable, Equatable {
    public var showsCPU: Bool
    public var showsMemory: Bool
    public var showsStorage: Bool
    public var showsBattery: Bool
    public var showsNetwork: Bool
    public var visibleCustomMetricsSourceIDs: Set<UUID>

    public var isEmpty: Bool {
        !showsCPU && !showsMemory && !showsStorage && !showsBattery && !showsNetwork
            && visibleCustomMetricsSourceIDs.isEmpty
    }

    public func showsCustomMetrics(of id: UUID) -> Bool {
        visibleCustomMetricsSourceIDs.contains(id)
    }

    public static let `default` = Self(
        showsCPU: true,
        showsMemory: false,
        showsStorage: false,
        showsBattery: false,
        showsNetwork: false,
        visibleCustomMetricsSourceIDs: []
    )
}
