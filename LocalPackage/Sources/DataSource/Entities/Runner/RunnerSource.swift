/*
 RunnerSource.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/10.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

public enum RunnerSource: Sendable {
    case builtIn(RunnerKind)
    case custom(name: String)
}
