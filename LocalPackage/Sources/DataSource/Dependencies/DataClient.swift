/*
 DataClient.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import ImageIO
import UniformTypeIdentifiers

public struct DataClient: DependencyClient {
    public var read: @Sendable (URL) throws -> Data
    public var write: @Sendable (Data, URL) throws -> Void
    public var convert: @Sendable (CGImage, UTType) throws -> Data

    public static let liveValue = Self(
        read: { try Data(contentsOf: $0) },
        write: { try $0.write(to: $1) },
        convert: {
            let data = NSMutableData()
            guard let destination = CGImageDestinationCreateWithData(data, $1.identifier as CFString, 1, nil) else {
                throw CGError.failure.nsError
            }
            CGImageDestinationAddImage(destination, $0, nil)
            guard CGImageDestinationFinalize(destination) else {
                throw CGError.failure.nsError
            }
            return data as Data
        }
    )

    public static let testValue = Self(
        read: { _ in Data() },
        write: { _, _ in },
        convert: { _, _ in Data() }
    )
}
