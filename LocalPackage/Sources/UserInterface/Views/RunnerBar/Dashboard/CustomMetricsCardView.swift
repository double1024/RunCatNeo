/*
 CustomMetricsCardView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/06.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import DataSource
import SwiftUI

struct CustomMetricsCardView: View {
    var snapshot: CustomMetricsSnapshot
    var isFailed: Bool
    var displayedDate: Date
    var onButtonTap: (CustomMetricButton) -> Void

    init(
        customMetricsBundle: CustomMetricsBundle,
        displayedDate: Date,
        onButtonTap: @escaping (CustomMetricButton) -> Void
    ) {
        self.snapshot = customMetricsBundle.snapshot
        self.isFailed = customMetricsBundle.isFailed
        self.displayedDate = displayedDate
        self.onButtonTap = onButtonTap
    }

    private var lastUpdatedDetail: String {
        if isFailed {
            String(localized: "failed", bundle: .module)
        } else {
            Date.AnchoredRelativeFormatStyle(anchor: snapshot.lastUpdatedDate, presentation: .named)
                .format(displayedDate)
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: snapshot.displaySymbol)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(.secondary)
                .frame(width: 24, height: 22)
            VStack(alignment: .leading, spacing: 4) {
                Text(verbatim: snapshot.title)
                    .font(.system(.body, weight: .semibold))
                ForEach(snapshot.metrics.enumerated(), id: \.offset) { _, metric in
                    Text(verbatim: "\(metric.title): \(metric.formattedValue)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                if let buttons = snapshot.buttons, !buttons.isEmpty {
                    HStack {
                        ForEach(buttons.enumerated(), id: \.offset) { _, button in
                            Button {
                                onButtonTap(button)
                            } label: {
                                Text(verbatim: button.title)
                            }
                        }
                    }
                }
                Text("lastUpdated:\(lastUpdatedDetail)", bundle: .module)
                    .font(.caption)
                    .foregroundStyle(isFailed ? Color.red : Color.secondary)
            }
        }
        .fixedSize()
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}
