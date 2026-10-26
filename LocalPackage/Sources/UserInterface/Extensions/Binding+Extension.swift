/*
 Binding+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import SwiftUI

extension Binding where Value : Sendable {
    @preconcurrency init(
        @_inheritActorContext get: @escaping @isolated(any) @Sendable () -> Value,
        @_inheritActorContext asyncSet: @escaping @isolated(any) @Sendable (Value) async -> Void
    ) {
        self.init(get: get, set: { newValue in Task { await asyncSet(newValue) } })
    }
}
