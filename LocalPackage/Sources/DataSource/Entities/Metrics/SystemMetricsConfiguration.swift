/*
 SystemMetricsConfiguration.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public struct SystemMetricsConfiguration: Codable, Sendable, Equatable {
    public var monitorsMemory: Bool
    public var monitorsStorage: Bool
    public var monitorsBattery: Bool
    public var monitorsNetwork: Bool

    static let `default` = Self(
        monitorsMemory: true,
        monitorsStorage: true,
        monitorsBattery: true,
        monitorsNetwork: true
    )
}
