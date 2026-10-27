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
    var isPreview: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let cpuInfo = systemInfoBundle.cpuInfo {
                SystemInfoView(systemInfo: cpuInfo)
            }
            if let memoryInfo = systemInfoBundle.memoryInfo {
                SystemInfoView(systemInfo: memoryInfo)
            }
            if let storageInfo = systemInfoBundle.storageInfo {
                SystemInfoView(systemInfo: storageInfo)
            }
            if let batteryInfo = systemInfoBundle.batteryInfo?.simulated(isPreview) {
                SystemInfoView(systemInfo: batteryInfo, isVisibleDetails: batteryInfo.isInstalled)
            }
            if let networkInfo = systemInfoBundle.networkInfo?.masked(isPreview) {
                SystemInfoView(
                    systemInfo: networkInfo,
                    iconName: "arrow.up.arrow.down",
                    detailStrings: Array(networkInfo.details.dropFirst())
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}
