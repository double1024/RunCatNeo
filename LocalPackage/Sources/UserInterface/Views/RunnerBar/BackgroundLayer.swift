/*
 BackgroundLayer.swift
 UserInterface

 Created by Takuto Nakamura on 2026/05/08.
 Copyright 2026 Kyome22 (Takuto Nakamura)

 */

import AppKit
import CoreImage.CIFilterBuiltins

final class BackgroundLayer: CALayer {
    private var gap: CGFloat

    init(gap: CGFloat) {
        self.gap = gap
        super.init()
        contentsGravity = CALayerContentsGravity.left
        masksToBounds = true
        contentsScale = 2.0
        let filter = CIFilter.sourceOutCompositing()
        let rect = CGRect(x: 0, y: 0, width: 600, height: 22)
        filter.backgroundImage = CIImage(color: CIColor.blue).cropped(to: rect)
        backgroundFilters = [filter]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSize(_ size: CGSize) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        frame = CGRect(origin: CGPoint(x: gap, y: 2.0), size: size)
        CATransaction.commit()
    }
}
