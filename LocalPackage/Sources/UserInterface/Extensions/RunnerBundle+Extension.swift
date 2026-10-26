/*
 RunnerBundle+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/31.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import SwiftUI

extension RunnerBundle {
    var thumbnail: Image {
        if case let .thumbnail(frame) = displayFormat, let nsImage = frame.nsImage {
            nsImage.normalize()
            nsImage.resize(width: 50, alignment: .trailing)
            nsImage.isTemplate = runner.isTemplate
            return Image(nsImage: nsImage)
        } else {
            return Image(systemName: "questionmark.square")
        }
    }
}

private extension Frame {
    var nsImage: NSImage? {
        switch self {
        case let .preset(resourceName):
            NSImage(resource: .init(name: resourceName, bundle: .module))
        case let .custom(data):
            NSImage(data: data)
        case .broken:
            nil
        }
    }
}
