/*
 FileWatcherClient.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Darwin
import Dispatch
import Foundation

public struct FileWatcherClient: DependencyClient {
    public var watch: @Sendable (URL) -> AsyncStream<Date>

    public static let liveValue = Self(
        watch: { url in
            AsyncStream<Date>(bufferingPolicy: .bufferingNewest(1)) { continuation in
                let descriptor = open(url.path, O_EVTONLY)
                guard descriptor >= 0 else {
                    continuation.finish()
                    return
                }
                let source = DispatchSource.makeFileSystemObjectSource(
                    fileDescriptor: descriptor,
                    eventMask: [.write, .rename, .delete, .extend],
                    queue: DispatchQueue.global(qos: .utility)
                )
                source.setEventHandler {
                    let data = source.data
                    continuation.yield(Date())
                    if data.contains(.rename) || data.contains(.delete) {
                        continuation.finish()
                    }
                }
                source.setCancelHandler {
                    close(descriptor)
                }
                source.resume()
                continuation.onTermination = { _ in
                    source.cancel()
                }
            }
        }
    )

    public static let testValue = Self(
        watch: { _ in AsyncStream { _ in } }
    )
}
