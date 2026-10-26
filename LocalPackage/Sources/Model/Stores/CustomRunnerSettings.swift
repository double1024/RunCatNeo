/*
 CustomRunnerSettings.swift
 Model

 Created by Takuto Nakamura on 2026/05/31.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AppKit
import DataSource
import Observation

@MainActor @Observable
public final class CustomRunnerSettings: Composable {
    private let appDependencies: AppDependencies
    private let appStateClient: AppStateClient
    private let uuidClient: UUIDClient
    private let logService: LogService
    private let runnerService: RunnerService

    public var customRunnerBundleList: [RunnerBundle]
    public var customRunnerEditor: CustomRunnerEditor?
    public var showingGuidancePopover: Bool
    public var showingAlert: Bool
    public var error: RCNError?
    public let action: (Action) async -> Void

    public init(
        _ appDependencies: AppDependencies,
        customRunnerBundleList: [RunnerBundle] = [],
        customRunnerEditor: CustomRunnerEditor? = nil,
        showingGuidancePopover: Bool = false,
        showingAlert: Bool = false,
        error: RCNError? = nil,
        action: @escaping (Action) async -> Void = { _ in }
    ) {
        self.appDependencies = appDependencies
        self.appStateClient = appDependencies.appStateClient
        self.uuidClient = appDependencies.uuidClient
        self.logService = .init(appDependencies)
        self.runnerService = .init(appDependencies)
        self.customRunnerBundleList = customRunnerBundleList
        self.customRunnerEditor = customRunnerEditor
        self.showingGuidancePopover = showingGuidancePopover
        self.showingAlert = showingAlert
        self.error = error
        self.action = action
    }

    public func reduce(_ action: Action) async {
        switch action {
        case .viewAppeared:
            customRunnerBundleList = appStateClient.withLock(\.runnerBundleLists.latestValue)?
                .filter(\.runner.isCustom) ?? []

        case let .deleteButtonTapped(runner):
            guard let currentRunner = appStateClient.withLock(\.runnerBundles.latestValue)?.runner else {
                return
            }
            do {
                guard currentRunner != runner else {
                    throw RCNError.customRunner(.runnerInUse)
                }
                customRunnerBundleList.removeAll { $0.runner == runner }
                try runnerService.delete(customRunner: runner)
            } catch let error as RCNError {
                await send(.errorOccurred(error))
            } catch {
                logService.critical(.deletingCustomRunnerFailed(error))
            }

        case let .customRunnerRowMoved(indexSet, offset):
            customRunnerBundleList.move(fromOffsets: indexSet, toOffset: offset)
            do {
                try runnerService.move(fromOffsets: indexSet, toOffset: offset)
            } catch {
                logService.critical(.sortingCustomRunnersFailed(error))
            }

        case .addCustomRunnerButtonTapped:
            customRunnerEditor = .init(
                appDependencies,
                id: uuidClient.create(),
                action: { [weak self] in
                    await self?.send(.customRunnerEditor($0))
                }
            )

        case .guidanceButtonTapped:
            showingGuidancePopover = true

        case .customRunnerEditor(.cancelButtonTapped):
            customRunnerEditor = nil

        case let .customRunnerEditor(.customRunnerAdded(runnerBundle)):
            customRunnerBundleList.append(runnerBundle)
            customRunnerEditor = nil

        case .customRunnerEditor:
            return

        case let .errorOccurred(error):
            self.error = error
            showingAlert = true
        }
    }

    public enum Action: Sendable {
        case viewAppeared
        case deleteButtonTapped(Runner)
        case customRunnerRowMoved(IndexSet, Int)
        case addCustomRunnerButtonTapped
        case guidanceButtonTapped
        case customRunnerEditor(CustomRunnerEditor.Action)
        case errorOccurred(RCNError)
    }
}
