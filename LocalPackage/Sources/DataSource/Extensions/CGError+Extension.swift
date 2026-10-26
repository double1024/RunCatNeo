/*
 CGError+Extension.swift
 DataSource

 Created by Takuto Nakamura on 2026/06/03.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import CoreGraphics
import Foundation

extension CGError {
    var nsError: NSError {
        NSError(
            domain: "com.apple.CoreGraphics.CGError",
            code: Int(rawValue),
            userInfo: nil
        )
    }
}
