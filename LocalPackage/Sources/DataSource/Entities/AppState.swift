/*
 AppState.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct AppState: Sendable {
    public var name: String
    public var version: String
    public var hasAlreadyBootstrap: Bool
    public var metrics = AsyncStreamBundle<Metrics>()
    public var systemMetricsConfigurationChanges = AsyncStreamBundle<Void>()
    public var customMetricsReconcileObserver: Task<Void, Never>?
    public var customMetricsObservers = [UUID: Task<Void, Never>]()
    public var customMetricsConfigurationChanges = AsyncStreamBundle<Void>()
    public var runnerBundleLists = AsyncStreamBundle<[RunnerBundle]>()
    public var runnerBundles = AsyncStreamBundle<RunnerBundle>()
    public var runnerSpeeds = AsyncStreamBundle<Float>()

    init(
        name: String = "",
        version: String = "",
        hasAlreadyBootstrap: Bool = false
    ) {
        self.name = name
        self.version = version
        self.hasAlreadyBootstrap = hasAlreadyBootstrap
    }
}
