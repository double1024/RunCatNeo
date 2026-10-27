/*
 MenuView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/23.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI

struct MenuView: View {
    var store: DashboardMenu

    private var aboutBody: AttributedString {
        var attributedString = AttributedString()

        var ossParagraph = AttributedString(String(localized: "oss", bundle: .module) + "\n")
        ossParagraph.foregroundColor = NSColor.textColor
        attributedString.append(ossParagraph)

        return attributedString
    }

    var body: some View {
        Group {
            Picker(selection: Binding<Runner?>(
                get: { store.currentRunner },
                asyncSet: { await store.send(.runnerKindPickerSelected($0)) }
            )) {
                ForEach(store.runnerBundleList, id: \.runner) { runnerBundle in
                    Label {
                        Text(runnerBundle.runner.formatted)
                    } icon: {
                        runnerBundle.thumbnail
                    }
                    .tag(runnerBundle.runner)
                }
            } label: {
                Label {
                    Text("runner", bundle: .module)
                } icon: {
                    Image(systemName: "pawprint.fill")
                }
            }
            Divider()
            SettingsLink {
                Label {
                    Text("settings", bundle: .module)
                } icon: {
                    Image(systemName: "gear")
                }
            }
            .buttonStyle(.preAction {
                await store.send(.settingsButtonTapped)
            })
            Button {
                Task {
                    await store.send(.activityMonitorButtonTapped)
                }
            } label: {
                Label {
                    Text("openActivityMonitor", bundle: .module)
                } icon: {
                    Image(.activityMonitor)
                }
            }
            Divider()
            Button {
                Task {
                    await store.send(.aboutButtonTapped(aboutBody))
                }
            } label: {
                Label {
                    Text("about\(store.appName)", bundle: .module)
                } icon: {
                    Image(systemName: "info.circle")
                }
            }
            Button {
                Task {
                    await store.send(.quitButtonTapped)
                }
            } label: {
                Label {
                    Text("quit\(store.appName)", bundle: .module)
                } icon: {
                    Image(systemName: "xmark.rectangle")
                }
            }
            .accessibilityIdentifier("terminate_app")
            if !store.isPreview, isDebugBuild {
                Divider()
                Button {
                    Task {
                        await store.send(.debugSleepButtonTapped)
                    }
                } label: {
                    Label {
                        Text("debugSleep", bundle: .module)
                    } icon: {
                        Image(systemName: "sleep")
                    }
                }
                Button {
                    Task {
                        await store.send(.debugWakeUpButtonTapped)
                    }
                } label: {
                    Label {
                        Text("debugWakeUp", bundle: .module)
                    } icon: {
                        Image(systemName: "wake")
                    }
                }
            }
        }
        .task {
            await store.send(.viewAppeared)
        }
        .onDisappear {
            Task {
                await store.send(.viewDisappeared)
            }
        }
    }
}
