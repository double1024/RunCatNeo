/*
 DisplayFormat.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/31.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public enum DisplayFormat: Sendable, Equatable {
    case keyFrameAnimation([Frame])
    case thumbnail(Frame)
}
