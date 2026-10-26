/*
 DashboardView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

struct DashboardView: View {
    @StateObject var store: Dashboard

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(store.appName)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 8)
                Spacer()
                MenuView(store: store.dashboardMenu)
            }
            SystemInfoStackView(
                systemInfoBundle: store.systemInfoBundle,
                cpuRingBuffer: store.cpuRingBuffer,
                memoryRingBuffer: store.memoryRingBuffer,
                isPreview: store.isPreview
            )
            ForEach(store.customMetricsBundles) { customMetricsBundle in
                CustomMetricsCardView(
                    customMetricsBundle: customMetricsBundle,
                    displayedDate: store.displayedDate,
                    onButtonTap: { button in
                        Task {
                            await store.send(.customMetricsButtonTapped(button.url))
                        }
                    }
                )
            }
        }
        .fixedSize()
        .padding(8)
        .task {
            await store.send(.viewAppeared(String(describing: Self.self)))
        }
        .onDisappear {
            Task {
                await store.send(.viewDisappeared)
            }
        }
    }
}

extension Dashboard: ObservableObject {}
