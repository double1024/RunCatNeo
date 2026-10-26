/*
 FrameImage.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/02.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation
import CoreGraphics

public struct FrameImage: Sendable, Hashable, Identifiable {
    public var id: UUID
    public var cgImage: CGImage

    public init(id: UUID, cgImage: CGImage) {
        self.id = id
        self.cgImage = cgImage
    }
}
