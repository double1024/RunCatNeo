/*
 CustomMetric.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public struct CustomMetric: Codable, Sendable, Equatable {
    public var title: String
    public var formattedValue: String
    public var normalizedValue: Double?

    public init(title: String, formattedValue: String, normalizedValue: Double? = nil) {
        self.title = title
        self.formattedValue = formattedValue
        self.normalizedValue = normalizedValue
    }
}

public struct CustomMetricButton: Codable, Sendable, Equatable {
    public var title: String
    public var url: String

    public init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
