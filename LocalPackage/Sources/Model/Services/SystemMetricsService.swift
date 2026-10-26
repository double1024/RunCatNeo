/*
 SystemMetricsService.swift
 Model

 Created by Takuto Nakamura on 2026/05/07.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import SystemInfoKit

struct SystemMetricsService {
    private let appStateClient: AppStateClient
    private let systemInfoObserverClient: SystemInfoObserverClient
    private let userDefaultsRepository: UserDefaultsRepository

    var currentSystemInfoBundle: SystemInfoBundle {
        systemInfoObserverClient.currentSystemInfo()
    }

    init(_ appDependencies: AppDependencies) {
        self.appStateClient = appDependencies.appStateClient
        self.systemInfoObserverClient = appDependencies.systemInfoObserverClient
        self.userDefaultsRepository = .init(appDependencies.userDefaultsClient)
    }

    func stopMonitoring() {
        systemInfoObserverClient.stopMonitoring()
    }

    func startMonitoring() {
        let configuration = userDefaultsRepository.systemMetricsConfiguration
        systemInfoObserverClient.toggleActivation([
            SystemInfoType.cpu: true,
            SystemInfoType.memory: configuration.monitorsMemory,
            SystemInfoType.storage: configuration.monitorsStorage,
            SystemInfoType.battery: configuration.monitorsBattery,
            SystemInfoType.network: configuration.monitorsNetwork,
        ])
        systemInfoObserverClient.startMonitoring(Double(userDefaultsRepository.updateInterval.seconds))
    }

    func toggleSystemMetricsActivation(type: SystemInfoType, isOn: Bool) {
        systemInfoObserverClient.toggleActivation([type: isOn])
    }

    func updateMetrics(from systemInfoBundle: SystemInfoBundle) {
        appStateClient.send(\.metrics, default: .init()) { metrics in
            metrics.systemInfoBundle = systemInfoBundle
            if let value = systemInfoBundle.cpuInfo?.percentage.value {
                metrics.cpuRingBuffer.append(value)
            }
            if let value = systemInfoBundle.memoryInfo?.percentage.value {
                metrics.memoryRingBuffer.append(value)
            }
        }
    }

    func emitConfigurationChange() {
        appStateClient.send(\.systemMetricsConfigurationChanges, ())
    }
}
