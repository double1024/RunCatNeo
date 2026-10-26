/*
 SystemInfoStackView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import Model
import SwiftUI
import SystemInfoKit

struct SystemInfoStackView: View {
    var systemInfoBundle: SystemInfoBundle
    var cpuRingBuffer: RingBuffer
    var memoryRingBuffer: RingBuffer
    var isPreview: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let cpuInfo = systemInfoBundle.cpuInfo {
                SystemInfoView(systemInfo: cpuInfo) {
                    LineGraphView(values: (isPreview ? RingBuffer.mock : cpuRingBuffer).values)
                }
            }
            if let memoryInfo = systemInfoBundle.memoryInfo {
                Divider()
                SystemInfoView(systemInfo: memoryInfo) {
                    LineGraphView(values: (isPreview ? RingBuffer.mock : memoryRingBuffer).values)
                }
            }
            if let storageInfo = systemInfoBundle.storageInfo {
                Divider()
                SystemInfoView(systemInfo: storageInfo) {
                    BarGraphView(value: storageInfo.percentage.value)
                }
            }
            if let batteryInfo = systemInfoBundle.batteryInfo?.simulated(isPreview) {
                Divider()
                SystemInfoView(systemInfo: batteryInfo, isVisibleDetails: batteryInfo.isInstalled) {
                    EmptyView()
                }
            }
            if let networkInfo = systemInfoBundle.networkInfo?.masked(isPreview) {
                Divider()
                SystemInfoView(systemInfo: networkInfo) {
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .materialCellStyle()
    }
}
