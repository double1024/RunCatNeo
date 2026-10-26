/*
 FileManagerClient.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct FileManagerClient: DependencyClient {
    public var urls: @Sendable (FileManager.SearchPathDirectory, FileManager.SearchPathDomainMask) -> [URL]
    public var fileExists: @Sendable (String) -> Bool
    public var createDirectory: @Sendable (URL, Bool) throws -> Void
    public var removeItem: @Sendable (URL) throws -> Void

    public static let liveValue = Self(
        urls: { FileManager.default.urls(for: $0, in: $1) },
        fileExists: { FileManager.default.fileExists(atPath: $0) },
        createDirectory: { try FileManager.default.createDirectory(at: $0, withIntermediateDirectories: $1) },
        removeItem: { try FileManager.default.removeItem(at: $0) }
    )

    public static let testValue = Self(
        urls: { _, _ in [URL(filePath: "/Users/user/Library/Application Support/")] },
        fileExists: { _ in false },
        createDirectory: { _, _ in },
        removeItem: { _ in }
    )
}
