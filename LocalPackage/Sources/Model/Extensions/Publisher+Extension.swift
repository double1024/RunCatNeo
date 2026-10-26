/*
 Publisher+Extension.swift
 Model

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Combine

extension Publisher where Self.Failure == Never {
    func bufferedValues() -> AsyncPublisher<Publishers.Buffer<Self>> {
        self.buffer(size: 5, prefetch: .keepFull, whenFull: .dropOldest)
            .values
    }
}
