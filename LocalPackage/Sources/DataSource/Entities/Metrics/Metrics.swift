/*
 Metrics.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/21.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SystemInfoKit

public struct Metrics: Sendable {
    public var systemInfoBundle: SystemInfoBundle
    public var cpuRingBuffer: RingBuffer
    public var memoryRingBuffer: RingBuffer
    public var customMetricsBundles: [CustomMetricsBundle]

    public init(
        systemInfoBundle: SystemInfoBundle = .cpuZero(),
        cpuRingBuffer: RingBuffer = .init(),
        memoryRingBuffer: RingBuffer = .init(),
        customMetricsBundles: [CustomMetricsBundle] = []
    ) {
        self.systemInfoBundle = systemInfoBundle
        self.cpuRingBuffer = cpuRingBuffer
        self.memoryRingBuffer = memoryRingBuffer
        self.customMetricsBundles = customMetricsBundles
    }
}
