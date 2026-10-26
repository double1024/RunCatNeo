/*
 RunnerBar.swift
 Model

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AppKit
import DataSource
import Observation

@MainActor @Observable
public final class RunnerBar: Composable {
    private let appStateClient: AppStateClient
    private let userDefaultsRepository: UserDefaultsRepository
    private let logService: LogService

    @ObservationIgnored private var eventBridge: Action.EventBridge?
    @ObservationIgnored private var tintColor = CGColor.black
    @ObservationIgnored private var appearance: NSAppearance?
    @ObservationIgnored private var isBuiltInRunner = false
    @ObservationIgnored private var task: Task<Void, Never>?

    public var icon: NSImage?
    public var size: CGSize
    public var isTemplate: Bool
    public let action: (Action) async -> Void

    public var isReady: Bool {
        eventBridge != nil
    }

    public init(
        _ appDependencies: AppDependencies,
        icon: NSImage? = nil,
        size: CGSize = .zero,
        isTemplate: Bool = false,
        action: @escaping (Action) async -> Void = { _ in }
    ) {
        self.appStateClient = appDependencies.appStateClient
        self.userDefaultsRepository = .init(appDependencies.userDefaultsClient)
        self.logService = .init(appDependencies)
        self.icon = icon
        self.size = size
        self.isTemplate = isTemplate
        self.action = action
    }

    public func reduce(_ action: Action) async {
        switch action {
        case let .viewAppeared(screenName, eventBridge):
            logService.notice(.screenView(name: screenName))
            self.eventBridge = eventBridge
            task?.cancel()
            task = Task.immediate { [weak self, appStateClient] in
                await withTaskGroup { group in
                    group.addImmediateTask {
                        for await value in StatusBarAppearanceBridge.shared.stream {
                            self?.update(appearance: value)
                        }
                    }
                    group.addImmediateTask {
                        let stream = appStateClient.withLock(\.runnerBundles.stream)
                        for await value in stream {
                            self?.update(runnerBundle: value)
                        }
                    }
                    group.addImmediateTask {
                        let stream = appStateClient.withLock(\.runnerSpeeds.stream)
                        for await value in stream {
                            self?.update(runnerSpeed: value)
                        }
                    }
                }
            }

        case .viewDisappeared:
            task?.cancel()
            task = nil
        }
    }

    private func update(appearance: NSAppearance) {
        self.appearance = appearance
        updateTintColor()
    }

    private func update(runnerBundle: RunnerBundle) {
        guard case let .keyFrameAnimation(frames) = runnerBundle.displayFormat else {
            return
        }
        let images = frames.compactMap { frame in
            switch frame {
            case let .preset(resourceName):
                eventBridge?.getBundleImage(resourceName)
            case let .custom(data):
                NSImage(data: data)
            case .broken:
                nil
            }
        }
        let isFlippedHorizontally = userDefaultsRepository.isFlippedHorizontally
        icon = images.first?.plane
        icon?.flip(enabled: isFlippedHorizontally)
        icon?.normalize()
        size = icon?.size ?? .zero
        eventBridge?.setSize(size)
        if case .builtIn = runnerBundle.runner.source {
            isBuiltInRunner = true
        } else {
            isBuiltInRunner = false
        }
        isTemplate = runnerBundle.runner.isTemplate
        updateTintColor()
        let imageFrames = images.map { image in
            image.flip(enabled: isFlippedHorizontally)
            image.normalize()
            image.isTemplate = isTemplate
            return image
        }
        eventBridge?.setFrames(imageFrames, isTemplate)
    }

    private func update(runnerSpeed: Float) {
        eventBridge?.setSpeed(runnerSpeed)
    }

    private func updateTintColor() {
        appearance?.performAsCurrentDrawingAppearance {
            let usesAccentColor = userDefaultsRepository.tintsBuiltInRunnerWithAccentColor
                && isBuiltInRunner
                && isTemplate
            tintColor = (usesAccentColor ? NSColor.controlAccentColor : NSColor.textColor).cgColor
        }
        eventBridge?.setColor(tintColor, isTemplate)
    }

    public enum Action: Sendable {
        case viewAppeared(String, EventBridge)
        case viewDisappeared

        public struct EventBridge: Sendable {
            public let getBundleImage: @MainActor @Sendable (String) -> NSImage
            public var setSize: @MainActor @Sendable (CGSize) -> Void
            public var setFrames: @MainActor @Sendable ([NSImage], Bool) -> Void
            public var setColor: @MainActor @Sendable (CGColor, Bool) -> Void
            public var setSpeed: @MainActor @Sendable (Float) -> Void

            public init(
                getBundleImage: @escaping @MainActor @Sendable (String) -> NSImage,
                setSize: @escaping @MainActor @Sendable (CGSize) -> Void,
                setFrames: @escaping @MainActor @Sendable ([NSImage], Bool) -> Void,
                setColor: @escaping @MainActor @Sendable (CGColor, Bool) -> Void,
                setSpeed: @escaping @MainActor @Sendable (Float) -> Void
            ) {
                self.getBundleImage = getBundleImage
                self.setSize = setSize
                self.setFrames = setFrames
                self.setColor = setColor
                self.setSpeed = setSpeed
            }
        }
    }
}
