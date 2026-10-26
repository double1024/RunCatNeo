/*
 NSWorkspaceClient.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AppKit
import Combine

public struct NSWorkspaceClient: DependencyClient {
    public var open: @Sendable (URL) -> Bool
    public var urlForApplication: @Sendable (String) -> URL?
    public var openApplication: @Sendable (URL, NSWorkspace.OpenConfiguration) -> Void
    public var activateFileViewerSelecting: @Sendable ([URL]) -> Void
    public var post: @Sendable (Notification.Name, Any?) -> Void
    public var publisher: @Sendable (Notification.Name) -> AnyPublisher<Notification, Never>

    public static let liveValue = Self(
        open: { NSWorkspace.shared.open($0) },
        urlForApplication: { NSWorkspace.shared.urlForApplication(withBundleIdentifier: $0) },
        openApplication: { NSWorkspace.shared.openApplication(at: $0, configuration: $1) },
        activateFileViewerSelecting: { NSWorkspace.shared.activateFileViewerSelecting($0) },
        post: { NSWorkspace.shared.notificationCenter.post(name: $0, object: $1) },
        publisher: { NSWorkspace.shared.notificationCenter.publisher(for: $0).eraseToAnyPublisher() }
    )

    public static let testValue = Self(
        open: { _ in false },
        urlForApplication: { _ in nil },
        openApplication: { _, _ in },
        activateFileViewerSelecting: { _ in },
        post: { _, _ in },
        publisher: { _ in Empty<Notification, Never>().eraseToAnyPublisher() }
    )
}
