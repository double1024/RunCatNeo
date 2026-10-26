/*
 RCNError.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/31.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public enum RCNError: Error, Equatable {
    case customRunner(CustomRunner)
    case customMetrics(CustomMetrics)

    public enum CustomRunner: Error {
        case runnerInUse
        case nameAlreadyExists
        case invalidFrameImage
        case frameLimitExceeded
        case savingFailed
        case loadingFailed
    }

    public enum CustomMetrics: Error {
        case fileUnreadable
        case invalidFormat
    }
}
