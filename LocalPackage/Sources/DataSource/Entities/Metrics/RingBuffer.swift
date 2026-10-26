/*
 RingBuffer.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/21.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public struct RingBuffer: Sendable {
    private let length: Int
    public private(set) var values: [Double]

    public init(length: Int = 61) {
        self.length = length
        values = [Double](repeating: 2, count: length)
    }

    public mutating func append(_ value: Double) {
        values.append(value)
        values.removeFirst()
    }

    public mutating func append(_ values: [Double]) {
        self.values.append(contentsOf: values)
        self.values = self.values.suffix(length)
    }
}
