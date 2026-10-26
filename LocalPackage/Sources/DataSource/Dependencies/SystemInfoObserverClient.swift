/*
 SystemInfoObserverClient.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/07.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SystemInfoKit

public struct SystemInfoObserverClient: DependencyClient {
    public var systemInfoStream: @Sendable () -> AsyncStream<SystemInfoBundle>
    public var currentSystemInfo: @Sendable () -> SystemInfoBundle
    public var startMonitoring: @Sendable (Double) -> Void
    public var stopMonitoring: @Sendable () -> Void
    public var toggleActivation: @Sendable ([SystemInfoType: Bool]) -> Void

    public static let liveValue = Self(
        systemInfoStream: { SystemInfoObserver.shared.systemInfoStream() },
        currentSystemInfo: { SystemInfoObserver.shared.currentSystemInfo },
        startMonitoring: { SystemInfoObserver.shared.startMonitoring(monitorInterval: $0) },
        stopMonitoring: { SystemInfoObserver.shared.stopMonitoring() },
        toggleActivation: { SystemInfoObserver.shared.toggleActivation(requests: $0) }
    )

    public static let testValue = Self(
        systemInfoStream: { AsyncStream { $0.finish() } },
        currentSystemInfo: { SystemInfoBundle() },
        startMonitoring: { _ in },
        stopMonitoring: {},
        toggleActivation: { _ in }
    )
}
