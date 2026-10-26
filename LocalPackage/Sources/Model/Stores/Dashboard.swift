/*
 Dashboard.swift
 Model

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Foundation
import Observation
import SystemInfoKit

@MainActor @Observable
public final class Dashboard: Composable {
    private let appStateClient: AppStateClient
    private let dateClient: DateClient
    private let logService: LogService
    private let nsWorkspaceClient: NSWorkspaceClient

    @ObservationIgnored private var task: Task<Void, Never>?

    private static let networkURLSchemes: Set<String> = [
        "http", "https", "ftp", "ftps", "sftp", "ssh", "mailto", "news", "nntp", "irc", "ircs",
        "itms", "itms-apps", "tel", "facetime", "webcal",
    ]

    public var appName: String
    public var systemInfoBundle: SystemInfoBundle
    public var cpuRingBuffer: RingBuffer
    public var memoryRingBuffer: RingBuffer
    public var customMetricsBundles: [CustomMetricsBundle]
    public var displayedDate: Date
    public let isPreview: Bool
    public let dashboardMenu: DashboardMenu
    public let action: (Action) async -> Void

    public init(
        _ appDependencies: AppDependencies,
        appName: String? = nil,
        systemInfoBundle: SystemInfoBundle = .cpuZero(),
        cpuRingBuffer: RingBuffer = .init(),
        memoryRingBuffer: RingBuffer = .init(),
        customMetricsBundles: [CustomMetricsBundle] = [],
        displayedDate: Date? = nil,
        isPreview: Bool? = nil,
        dashboardMenu: DashboardMenu? = nil,
        action: @escaping (Action) async -> Void =  { _ in }
    ) {
        self.appStateClient = appDependencies.appStateClient
        self.dateClient = appDependencies.dateClient
        self.logService = .init(appDependencies)
        self.nsWorkspaceClient = appDependencies.nsWorkspaceClient
        self.appName = appName ?? appStateClient.withLock(\.name)
        self.systemInfoBundle = systemInfoBundle
        self.cpuRingBuffer = cpuRingBuffer
        self.memoryRingBuffer = memoryRingBuffer
        self.customMetricsBundles = customMetricsBundles
        self.displayedDate = displayedDate ?? dateClient.now()
        self.isPreview = isPreview ?? ProcessInfo.isPreview
        weak var weakSelf: Dashboard? = nil
        self.dashboardMenu = dashboardMenu ??
            .init(appDependencies, action: { await weakSelf?.send(.dashboardMenu($0)) })
        self.action = action
        weakSelf = self
    }

    public func reduce(_ action: Action) async {
        switch action {
        case let .viewAppeared(screenName):
            logService.notice(.screenView(name: screenName))
            displayedDate = dateClient.now()
            if let metrics = appStateClient.withLock(\.metrics.latestValue) {
                updateMetrics(metrics)
            }
            task?.cancel()
            task = Task.immediate { [weak self, appStateClient] in
                let stream = appStateClient.withLock(\.metrics.stream)
                for await value in stream {
                    self?.updateMetrics(value)
                }
            }

        case .viewDisappeared:
            task?.cancel()
            task = nil

        case .dashboardMenu:
            return

        case let .customMetricsButtonTapped(urlString):
            guard let url = URL(string: urlString),
                  let scheme = url.scheme?.lowercased(),
                  !Self.networkURLSchemes.contains(scheme) else {
                logService.error(.openingCustomMetricsButtonFailed(reason: "Invalid URL or network URL scheme."))
                return
            }
            guard nsWorkspaceClient.open(url) else {
                logService.error(.openingCustomMetricsButtonFailed(reason: "NSWorkspace.open returned false."))
                return
            }
        }
    }

    private func updateMetrics(_ metrics: Metrics) {
        systemInfoBundle = metrics.systemInfoBundle
        cpuRingBuffer = metrics.cpuRingBuffer
        memoryRingBuffer = metrics.memoryRingBuffer
        customMetricsBundles = metrics.customMetricsBundles
    }

    public enum Action: Sendable {
        case viewAppeared(String)
        case viewDisappeared
        case dashboardMenu(DashboardMenu.Action)
        case customMetricsButtonTapped(String)
    }
}
