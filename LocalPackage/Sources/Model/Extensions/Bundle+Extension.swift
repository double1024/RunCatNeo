/*
 Bundle+Extension.swift
 Model

 Created by Takuto Nakamura on 2026/05/05.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Foundation

extension Bundle {
    private func bundleString(key: String) -> String {
        guard let string = object(forInfoDictionaryKey: key) as? String else {
            fatalError("\(key) is not found.")
        }
        return string
    }

    var bundleDisplayName: String { bundleString(key: "CFBundleDisplayName") }
    var bundleShortVersion: String { bundleString(key: "CFBundleShortVersionString") }
    var bundleVersion: String { bundleString(key: "CFBundleVersion") }
}
