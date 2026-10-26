/*
 CriticalEvent.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Logging

public enum CriticalEvent {
    case setupFailed(any Error)
    case deletingCustomRunnerFailed(any Error)
    case sortingCustomRunnersFailed(any Error)
    case unknown(any Error)

    public var message: Logger.Message {
        switch self {
        case .setupFailed:
            "Failed to setup."
        case .deletingCustomRunnerFailed:
            "Failed deleting custom runner."
        case .sortingCustomRunnersFailed:
            "Failed sorting custom runners."
        case .unknown:
            "An unknown error has occurred."
        }
    }

    public var metadata: Logger.Metadata? {
        switch self {
        case let .setupFailed(error),
            let .deletingCustomRunnerFailed(error),
            let .sortingCustomRunnersFailed(error),
            let .unknown(error):
            ["cause": "\(error.localizedDescription)"]
        }
    }
}
