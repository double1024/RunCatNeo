/*
 LaunchAtLoginRepository.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct LaunchAtLoginRepository: Sendable {
    private var smAppServiceClient: SMAppServiceClient

    public var isEnabled: Bool {
        smAppServiceClient.status() == .enabled
    }

    public init(_ smAppServiceClient: SMAppServiceClient) {
        self.smAppServiceClient = smAppServiceClient
    }

    public func switchStatus(_ isEnabled: Bool) -> Result<Void, OperationError> {
        let switchSucceeded: Bool = {
            do {
                if isEnabled {
                    try smAppServiceClient.register()
                } else {
                    try smAppServiceClient.unregister()
                }
                return true
            } catch {
                return false
            }
        }()
        let value = self.isEnabled
        return if switchSucceeded, value == isEnabled {
            .success(())
        } else {
            .failure(.switchFailed(value))
        }
    }

    public enum OperationError: Error, Equatable {
        case switchFailed(Bool)
    }
}
