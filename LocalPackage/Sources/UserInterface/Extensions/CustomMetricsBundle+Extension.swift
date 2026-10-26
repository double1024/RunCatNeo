/*
 CustomMetricsBundle+Extension.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/10.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource

extension CustomMetricsBundle {
    var metricsBarLabel: String {
        if isFailed {
            "---"
        } else {
            snapshot.metricsBarValue ?? "---"
        }
    }
}
