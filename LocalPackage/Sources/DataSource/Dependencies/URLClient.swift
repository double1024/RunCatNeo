/*
 URLClient.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct URLClient: DependencyClient {
    public var create: @Sendable (Data, URL.BookmarkResolutionOptions) throws -> (Bool, URL)
    public var bookmarkData: @Sendable (URL, URL.BookmarkCreationOptions) throws -> Data
    public var startAccessingSecurityScopedResource: @Sendable (URL) -> Bool
    public var stopAccessingSecurityScopedResource: @Sendable (URL) -> Void

    public static let liveValue = Self(
        create: {
            var isStale = false
            let url = try URL(resolvingBookmarkData: $0, options: $1, bookmarkDataIsStale: &isStale)
            return (isStale, url)
        },
        bookmarkData: {
            try $0.bookmarkData(options: $1)
        },
        startAccessingSecurityScopedResource: {
            $0.startAccessingSecurityScopedResource()
        },
        stopAccessingSecurityScopedResource: {
            $0.stopAccessingSecurityScopedResource()
        }
    )

    public static let testValue = Self(
        create: { _, _ in throw URLError(.unknown) },
        bookmarkData: { _, _ in throw URLError(.unknown) },
        startAccessingSecurityScopedResource: { _ in false },
        stopAccessingSecurityScopedResource: { _ in }
    )
}
