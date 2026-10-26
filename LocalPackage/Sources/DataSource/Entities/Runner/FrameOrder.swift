/*
 FrameOrder.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public enum FrameOrder: Sendable {
    case ascending(Int)
    case swing
    case pendulum
    case partyHorn
    case custom([Int])

    var order: [Int] {
        switch self {
        case let .ascending(n):
            Array(.zero ..< n)
        case .swing:
            [0, 1, 2, 3, 4, 3, 2, 1]
        case .pendulum:
            [0, 1, 2, 1, 0, 3, 4, 3]
        case .partyHorn:
            [0, 1, 2, 3, 4, 4, 3, 2, 1]
        case let .custom(order):
            order
        }
    }

    public subscript(index: Int) -> Int {
        let o = order
        return if index < o.count {
            o[index]
        } else {
            .zero
        }
    }
}

extension FrameOrder: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let order = try container.decode([Int].self)
        self = .custom(order)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(order)
    }
}
