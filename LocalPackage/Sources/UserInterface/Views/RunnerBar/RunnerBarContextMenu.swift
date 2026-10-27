/*
 RunnerBarContextMenu.swift
 UserInterface

 Created by Takuto Nakamura on 2026/10/27.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AppKit
import DataSource
import Model
import SwiftUI

@MainActor
final class RunnerBarContextMenu: NSObject {
    private let store: DashboardMenu
    private let showSettings: () -> Void

    init(store: DashboardMenu, openSettings: @escaping () -> Void) {
        self.store = store
        self.showSettings = openSettings
    }

    func makeMenu() -> NSMenu {
        let menu = NSMenu()

        let runnerItem = NSMenuItem(
            title: String(localized: "runner", bundle: .module),
            action: nil,
            keyEquivalent: ""
        )
        runnerItem.image = NSImage(systemSymbolName: "pawprint.fill", accessibilityDescription: nil)

        let runnerMenu = NSMenu()
        for runnerBundle in store.runnerBundleList {
            let runner = runnerBundle.runner
            let item = NSMenuItem(
                title: runner.formatted,
                action: #selector(selectRunner(_:)),
                keyEquivalent: ""
            )
            item.target = self
            item.representedObject = runner.id
            item.state = runner == store.currentRunner ? .on : .off
            if case let .thumbnail(frame) = runnerBundle.displayFormat {
                item.image = thumbnail(for: frame, isTemplate: runner.isTemplate)
            }
            runnerMenu.addItem(item)
        }
        runnerItem.submenu = runnerMenu
        menu.addItem(runnerItem)
        menu.addItem(.separator())

        addItem(
            to: menu,
            title: String(localized: "settings", bundle: .module),
            symbolName: "gear",
            action: #selector(openSettings)
        )
        addItem(
            to: menu,
            title: String(localized: "openActivityMonitor", bundle: .module),
            symbolName: "chart.bar.xaxis",
            action: #selector(openActivityMonitor)
        )
        menu.addItem(.separator())
        addItem(
            to: menu,
            title: String(localized: "about\(store.appName)", bundle: .module),
            symbolName: "info.circle",
            action: #selector(showAbout)
        )
        addItem(
            to: menu,
            title: String(localized: "quit\(store.appName)", bundle: .module),
            symbolName: "xmark.rectangle",
            action: #selector(quit)
        )

#if DEBUG
        if !store.isPreview {
            menu.addItem(.separator())
            addItem(
                to: menu,
                title: String(localized: "debugSleep", bundle: .module),
                symbolName: "sleep",
                action: #selector(simulateSleep)
            )
            addItem(
                to: menu,
                title: String(localized: "debugWakeUp", bundle: .module),
                symbolName: "wake",
                action: #selector(simulateWakeUp)
            )
        }
#endif

        return menu
    }

    private func addItem(to menu: NSMenu, title: String, symbolName: String, action: Selector) {
        let item = NSMenuItem(title: title, action: action, keyEquivalent: "")
        item.target = self
        item.image = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil)
        menu.addItem(item)
    }

    private func thumbnail(for frame: Frame, isTemplate: Bool) -> NSImage? {
        let image: NSImage?
        switch frame {
        case let .preset(resourceName):
            image = NSImage(resource: .init(name: resourceName, bundle: .module))
        case let .custom(data):
            image = NSImage(data: data)
        case .broken:
            image = nil
        }
        guard let image, let thumbnail = image.copy() as? NSImage else { return nil }
        thumbnail.normalize()
        thumbnail.resize(width: 50, alignment: .trailing)
        thumbnail.isTemplate = isTemplate
        return thumbnail
    }

    private var aboutBody: AttributedString {
        var attributedString = AttributedString()
        var ossParagraph = AttributedString(String(localized: "oss", bundle: .module) + "\n")
        ossParagraph.foregroundColor = NSColor.textColor
        attributedString.append(ossParagraph)
        return attributedString
    }

    @objc private func selectRunner(_ sender: NSMenuItem) {
        guard let id = sender.representedObject as? String,
              let runner = store.runnerBundleList.first(where: { $0.runner.id == id })?.runner else {
            return
        }
        Task {
            await store.send(.runnerKindPickerSelected(runner))
        }
    }

    @objc private func openSettings() {
        Task {
            await store.send(.settingsButtonTapped)
            showSettings()
        }
    }

    @objc private func openActivityMonitor() {
        Task {
            await store.send(.activityMonitorButtonTapped)
        }
    }

    @objc private func showAbout() {
        Task {
            await store.send(.aboutButtonTapped(aboutBody))
        }
    }

    @objc private func quit() {
        Task {
            await store.send(.quitButtonTapped)
        }
    }

    @objc private func simulateSleep() {
        Task {
            await store.send(.debugSleepButtonTapped)
        }
    }

    @objc private func simulateWakeUp() {
        Task {
            await store.send(.debugWakeUpButtonTapped)
        }
    }
}
