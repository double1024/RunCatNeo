/*
 CustomMetricsSnapshot.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct CustomMetricsSnapshot: Codable, Sendable, Equatable {
    public var title: String
    public var symbol: String?
    public var metricsBarValue: String?
    public var metrics: [CustomMetric]
    public var buttons: [CustomMetricButton]?
    public var lastUpdatedDate: Date

    public init(
        title: String,
        symbol: String? = nil,
        metricsBarValue: String? = nil,
        metrics: [CustomMetric] = [],
        buttons: [CustomMetricButton]? = nil,
        lastUpdatedDate: Date
    ) {
        self.title = title
        self.symbol = symbol
        self.metricsBarValue = metricsBarValue
        self.metrics = metrics
        self.buttons = buttons
        self.lastUpdatedDate = lastUpdatedDate
    }
}
