/*
 RingBuffer+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/21.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource

extension RingBuffer {
    static var mock: RingBuffer {
        var ringBuffer = RingBuffer()
        ringBuffer.append((0 ..< 61).map { _ in Double.random(in: 2 ... 100) })
        return ringBuffer
    }
}
