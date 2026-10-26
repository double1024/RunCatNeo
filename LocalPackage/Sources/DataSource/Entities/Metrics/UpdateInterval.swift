/*
 UpdateInterval.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public enum UpdateInterval: Int, Sendable, Identifiable, CaseIterable {
    case threeSeconds = 3
    case fiveSeconds = 5
    case tenSeconds = 10

    public var id: Int { rawValue }

    public var seconds: Int { rawValue }

    public static let `default` = UpdateInterval.fiveSeconds
}
