/*
 RunnerPreviewView.swift
 UserInterface

 Created by Takuto Nakamura on 2026/06/03.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import Model
import SwiftUI

struct RunnerPreviewView: View {
    @Bindable var store: CustomRunnerEditor

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Group {
                if let frameImage = store.previewingFrameImage {
                    Image(frameImage.cgImage, scale: 1.0, label: Text("preview", bundle: .module))
                        .renderingMode(store.isTemplate ? .template : .original)
                        .resizable()
                        .scaledToFit()
                } else {
                    Color.clear
                }
            }
            .frame(width: 100, height: 36)
            .padding(4)
            .border(Color(.separatorColor))
            Slider(value: $store.previewSpeed, in: 0 ... 3, step: 1) {
                EmptyView()
            } minimumValueLabel: {
                Image(systemName: "tortoise.fill")
            } maximumValueLabel: {
                Image(systemName: "hare.fill")
            }
            .labelsHidden()
        }
    }
}
