/*
 CustomMetricsConfiguration.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public struct CustomMetricsConfiguration: Codable, Sendable, Equatable {
    public var sources: [CustomMetricsSource]

    public init(sources: [CustomMetricsSource] = []) {
        self.sources = sources
    }

    public static let empty = CustomMetricsConfiguration()
}
