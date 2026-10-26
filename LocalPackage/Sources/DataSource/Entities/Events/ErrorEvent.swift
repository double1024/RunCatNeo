/*
 ErrorEvent.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Logging

public enum ErrorEvent {
    case importingCustomMetricsSourceFailed(any Error)
    case importingFrameImagesFailed(any Error)
    case openingCustomMetricsButtonFailed(reason: String)
    case switchingRunnerFailed(any Error)

    public var message: Logger.Message {
        switch self {
        case .importingCustomMetricsSourceFailed:
            "Failed importing custom metrics source."
        case .importingFrameImagesFailed:
            "Failed importing frame images."
        case .openingCustomMetricsButtonFailed:
            "Failed opening custom metrics button URL."
        case .switchingRunnerFailed:
            "Failed switching runner."
        }
    }

    public var metadata: Logger.Metadata? {
        switch self {
        case let .importingCustomMetricsSourceFailed(error),
            let .importingFrameImagesFailed(error),
            let .switchingRunnerFailed(error):
            ["cause": "\(error.localizedDescription)"]
        case let .openingCustomMetricsButtonFailed(reason):
            ["cause": .string(reason)]
        }
    }
}
