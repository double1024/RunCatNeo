/*
 Array+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/25.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import CoreGraphics

extension Array where Element == CGFloat {
    func joined(separator: CGFloat) -> CGFloat {
        reduce(.zero) {
            if $0 > .zero {
                $0 + separator + $1
            } else {
                $0 + $1
            }
        }
    }
}
