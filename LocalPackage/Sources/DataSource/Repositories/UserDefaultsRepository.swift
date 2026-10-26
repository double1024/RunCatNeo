/*
 UserDefaultsRepository.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

public struct UserDefaultsRepository: Sendable {
    private var userDefaultsClient: UserDefaultsClient

    public var runnerID: Runner.ID {
        get { userDefaultsClient.string(.runnerID) ?? RunnerKind.cat.id }
        nonmutating set { userDefaultsClient.set(newValue, .runnerID) }
    }

    public var speedDecreasesUnderLoad: Bool {
        get { userDefaultsClient.bool(.speedDecreasesUnderLoad) }
        nonmutating set { userDefaultsClient.set(newValue, .speedDecreasesUnderLoad) }
    }

    public var isFlippedHorizontally: Bool {
        get { userDefaultsClient.bool(.isFlippedHorizontally) }
        nonmutating set { userDefaultsClient.set(newValue, .isFlippedHorizontally) }
    }

    public var tintsBuiltInRunnerWithAccentColor: Bool {
        get { userDefaultsClient.bool(.tintsBuiltInRunnerWithAccentColor) }
        nonmutating set { userDefaultsClient.set(newValue, .tintsBuiltInRunnerWithAccentColor) }
    }

    public var updateInterval: UpdateInterval {
        get { UpdateInterval(rawValue: userDefaultsClient.integer(.updateInterval)) ?? .default }
        nonmutating set { userDefaultsClient.set(newValue.rawValue, .updateInterval) }
    }

    public var systemMetricsConfiguration: SystemMetricsConfiguration {
        get {
            guard let data = userDefaultsClient.data(.systemMetricsConfiguration),
                  let value = try? JSONDecoder().decode(SystemMetricsConfiguration.self, from: data) else {
                return .default
            }
            return value
        }
        nonmutating set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaultsClient.set(data, .systemMetricsConfiguration)
            } else {
                userDefaultsClient.removeObject(.systemMetricsConfiguration)
            }
        }
    }

    public var showsMetricsBar: Bool {
        get { userDefaultsClient.bool(.showsMetricsBar) }
        nonmutating set { userDefaultsClient.set(newValue, .showsMetricsBar) }
    }

    public var metricsBarConfiguration: MetricsBarConfiguration {
        get {
            guard let data = userDefaultsClient.data(.metricsBarConfiguration),
                  let value = try? JSONDecoder().decode(MetricsBarConfiguration.self, from: data) else {
                return .default
            }
            return value
        }
        nonmutating set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaultsClient.set(data, .metricsBarConfiguration)
            } else {
                userDefaultsClient.removeObject(.metricsBarConfiguration)
            }
        }
    }

    public var customMetricsConfiguration: CustomMetricsConfiguration {
        get {
            guard let data = userDefaultsClient.data(.customMetricsConfiguration),
                  let value = try? JSONDecoder().decode(CustomMetricsConfiguration.self, from: data) else {
                return .empty
            }
            return value
        }
        nonmutating set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaultsClient.set(data, .customMetricsConfiguration)
            } else {
                userDefaultsClient.removeObject(.customMetricsConfiguration)
            }
        }
    }

    public init(_ userDefaultsClient: UserDefaultsClient) {
        self.userDefaultsClient = userDefaultsClient
        if ProcessInfo.needsResetUserDefaults {
            userDefaultsClient.removePersistentDomain(Bundle.main.bundleIdentifier!)
        }
        userDefaultsClient.register([
            .runnerID: RunnerKind.cat.id,
            .speedDecreasesUnderLoad: false,
            .isFlippedHorizontally: false,
            .tintsBuiltInRunnerWithAccentColor: false,
            .updateInterval: UpdateInterval.default.rawValue,
        ])
        if ProcessInfo.needsShowAllData {
            showAllData()
        }
    }

    private func showAllData() {
        guard let dict = userDefaultsClient.persistentDomain(Bundle.main.bundleIdentifier!) else {
            return
        }
        for (key, value) in dict.sorted(by: { $0.0 < $1.0 }) {
            Swift.print("\(key) => \(value)")
        }
    }
}
