/*
 CustomMetricsSource.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct CustomMetricsSource: Codable, Sendable, Equatable, Identifiable {
    public var id: UUID
    public var displayName: String
    public var symbol: String?
    public var fileURL: URL
    public var bookmark: Data
    public var createdAt: Date

    public init(
        id: UUID,
        displayName: String,
        symbol: String? = nil,
        fileURL: URL,
        bookmark: Data,
        createdAt: Date
    ) {
        self.id = id
        self.displayName = displayName
        self.symbol = symbol
        self.fileURL = fileURL
        self.bookmark = bookmark
        self.createdAt = createdAt
    }
}
