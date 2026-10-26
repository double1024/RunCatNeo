/*
 RCNError+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/31.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Foundation

extension RCNError.CustomRunner: LocalizedError {
    public var errorDescription: String? {
        let localizationValue: String.LocalizationValue = switch self {
        case .runnerInUse:
            "runnerInUse"
        case .nameAlreadyExists:
            "nameAlreadyExists"
        case .invalidFrameImage:
            "invalidFrameImage"
        case .frameLimitExceeded:
            "frameLimitExceeded"
        case .savingFailed:
            "savingFailed"
        case .loadingFailed:
            "loadingFailed"
        }
        return String(localized: localizationValue, bundle: .module)
    }
}

extension RCNError.CustomMetrics: LocalizedError {
    public var errorDescription: String? {
        let localizationValue: String.LocalizationValue = switch self {
        case .fileUnreadable:
            "fileUnreadable"
        case .invalidFormat:
            "invalidFormat"
        }
        return String(localized: localizationValue, bundle: .module)
    }
}

extension RCNError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .customRunner(detail):
            detail.errorDescription
        case let .customMetrics(detail):
            detail.errorDescription
        }
    }
}
