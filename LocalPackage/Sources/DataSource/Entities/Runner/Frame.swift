/*
 Frame.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public enum Frame: Sendable, Equatable {
    case preset(String)
    case custom(Data)
    case broken
}
