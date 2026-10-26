/*
 MetricsBar.swift
 Model

 Created by Takuto Nakamura on 2026/05/24.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Foundation
import Observation
import SystemInfoKit

@MainActor @Observable
public final class MetricsBar: Composable {
    private let appStateClient: AppStateClient
    private let userDefaultsRepository: UserDefaultsRepository
    private let logService: LogService

    @ObservationIgnored private var task: Task<Void, Never>?

    public var metricsBarConfiguration: MetricsBarConfiguration
    public var systemInfoBundle: SystemInfoBundle
    public var customMetricsBundles: [CustomMetricsBundle]
    public let isPreview: Bool
    public let action: (Action) async -> Void

    public init(
        _ appDependencies: AppDependencies,
        metricsBarConfiguration: MetricsBarConfiguration? = nil,
        systemInfoBundle: SystemInfoBundle = .init(),
        customMetricsBundles: [CustomMetricsBundle] = [],
        isPreview: Bool? = nil,
        action: @escaping (Action) async -> Void = { _ in }
    ) {
        self.appStateClient = appDependencies.appStateClient
        self.userDefaultsRepository = .init(appDependencies.userDefaultsClient)
        self.logService = .init(appDependencies)
        self.metricsBarConfiguration = metricsBarConfiguration ?? userDefaultsRepository.metricsBarConfiguration
        self.systemInfoBundle = systemInfoBundle
        self.customMetricsBundles = customMetricsBundles
        self.isPreview = isPreview ?? ProcessInfo.isPreview
        self.action = action
    }

    public func reduce(_ action: Action) async {
        switch action {
        case let .viewAppeared(screenName):
            logService.notice(.screenView(name: screenName))
            if let metrics = appStateClient.withLock(\.metrics.latestValue) {
                updateMetrics(from: metrics)
            }
            task?.cancel()
            task = Task.immediate { [weak self, appStateClient] in
                await withTaskGroup { group in
                    group.addImmediateTask {
                        let stream = appStateClient.withLock(\.metrics.stream)
                        for await value in stream {
                            self?.updateMetrics(from: value)
                        }
                    }
                    group.addImmediateTask {
                        let stream = appStateClient.withLock(\.systemMetricsConfigurationChanges.stream)
                        for await _ in stream {
                            self?.updateMetricsBarConfiguration()
                        }
                    }
                    group.addImmediateTask {
                        let stream = appStateClient.withLock(\.customMetricsConfigurationChanges.stream)
                        for await _ in stream {
                            self?.updateMetricsBarConfiguration()
                        }
                    }
                }
            }

        case .viewDisappeared:
            task?.cancel()
            task = nil
        }
    }

    private func updateMetrics(from metrics: Metrics) {
        systemInfoBundle = metrics.systemInfoBundle
        customMetricsBundles = metrics.customMetricsBundles
    }

    private func updateMetricsBarConfiguration() {
        metricsBarConfiguration = userDefaultsRepository.metricsBarConfiguration
    }

    public enum Action: Sendable {
        case viewAppeared(String)
        case viewDisappeared
    }
}
