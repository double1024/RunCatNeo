/*
 RunnerBundle.swift
 DataSource

 Created by Takuto Nakamura on 2026/05/09.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public struct RunnerBundle: Sendable, Equatable, Identifiable {
    public var runner: Runner
    public var displayFormat: DisplayFormat

    public var id: Runner.ID { runner.id }

    public init(runner: Runner, frames: [Frame]) {
        self.runner = runner
        self.displayFormat = .keyFrameAnimation(frames)
    }

    public init(runner: Runner, frame: Frame) {
        self.runner = runner
        self.displayFormat = .thumbnail(frame)
    }
}
