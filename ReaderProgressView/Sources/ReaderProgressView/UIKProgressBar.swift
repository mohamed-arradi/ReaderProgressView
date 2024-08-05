// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit
import SwiftUI

fileprivate extension Color {
    static func convert(_ color: Color) -> UIColor {
        return UIColor(color)
    }
}

class UIKProgressBar: UIView {

    private let progressView = UIView()
    private let remainingView = UIView()
    private let spaceView = UIView()
    private let spaceBetweenBars: CGFloat = 8.0
    private let cornerRadius: CGFloat = 4
    
    var progressColor: Color = .black {
        didSet {
            setupViews()
        }
    }
    var trackColor: Color = .gray.opacity(0.3) {
        didSet {
            setupViews()
        }
    }
    
    var progress: CGFloat = 0.0 {
        didSet {
            updateProgressViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        remainingView.backgroundColor = Color.convert(trackColor)
        addSubview(remainingView)
        
        progressView.backgroundColor = Color.convert(progressColor)
        addSubview(progressView)
        
        spaceView.backgroundColor = UIColor.clear
        addSubview(spaceView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateProgressViews()
    }

    private func updateProgressViews() {
        let totalWidth = bounds.width
        let progressWidth = totalWidth * progress
        
        // Set the frame for the progress view
        progressView.frame = CGRect(x: 0, y: 0, width: progressWidth, height: bounds.height)
        applyRoundedCorners(to: progressView, start: true, end: progressWidth < totalWidth)
        
        if progress >= 1.0 {
            // Hide the remaining view and space view when progress is 1.0
            remainingView.isHidden = true
            spaceView.isHidden = true
        } else if progress >= 0 {
            progressView.isHidden = false
            // Show and position the space view
            let spaceX = progressWidth
            spaceView.frame = CGRect(x: spaceX, y: 0, width: spaceBetweenBars, height: bounds.height)
            applyRoundedCorners(to: spaceView, start: progressWidth > 0, end: true)
            
            // Show and position the remaining view
            let remainingX = spaceX + spaceBetweenBars
            let remainingWidth = totalWidth - progressWidth - spaceBetweenBars
            remainingView.frame = CGRect(x: remainingX, y: 0, width: remainingWidth, height: bounds.height)
            remainingView.isHidden = false
            applyRoundedCorners(to: remainingView, start: progressWidth < totalWidth, end: remainingWidth > 0)
        } else {
            progressView.isHidden = true
            spaceView.isHidden = true
        }
    }

    private func applyRoundedCorners(to view: UIView, start: Bool, end: Bool) {
        let path = UIBezierPath()
        let rect = view.bounds

        let radius = cornerRadius
        let startX = rect.minX
        let endX = rect.maxX
        let topY = rect.minY
        let bottomY = rect.maxY

        if start && end {
            // Rounded on both ends
            path.move(to: CGPoint(x: startX + radius, y: topY))
            path.addLine(to: CGPoint(x: endX - radius, y: topY))
            path.addQuadCurve(to: CGPoint(x: endX, y: topY + radius), controlPoint: CGPoint(x: endX, y: topY))
            path.addLine(to: CGPoint(x: endX, y: bottomY - radius))
            path.addQuadCurve(to: CGPoint(x: endX - radius, y: bottomY), controlPoint: CGPoint(x: endX, y: bottomY))
            path.addLine(to: CGPoint(x: startX + radius, y: bottomY))
            path.addQuadCurve(to: CGPoint(x: startX, y: bottomY - radius), controlPoint: CGPoint(x: startX, y: bottomY))
            path.addLine(to: CGPoint(x: startX, y: topY + radius))
            path.addQuadCurve(to: CGPoint(x: startX + radius, y: topY), controlPoint: CGPoint(x: startX, y: topY))
        } else if start {
            // Rounded on start end
            path.move(to: CGPoint(x: startX + radius, y: topY))
            path.addLine(to: CGPoint(x: endX, y: topY))
            path.addLine(to: CGPoint(x: endX, y: bottomY))
            path.addLine(to: CGPoint(x: startX + radius, y: bottomY))
            path.addQuadCurve(to: CGPoint(x: startX, y: bottomY - radius), controlPoint: CGPoint(x: startX, y: bottomY))
            path.addQuadCurve(to: CGPoint(x: startX + radius, y: topY), controlPoint: CGPoint(x: startX, y: topY))
        } else if end {
            // Rounded on end
            path.move(to: CGPoint(x: startX, y: topY))
            path.addLine(to: CGPoint(x: endX - radius, y: topY))
            path.addQuadCurve(to: CGPoint(x: endX, y: topY + radius), controlPoint: CGPoint(x: endX, y: topY))
            path.addLine(to: CGPoint(x: endX, y: bottomY - radius))
            path.addQuadCurve(to: CGPoint(x: endX - radius, y: bottomY), controlPoint: CGPoint(x: endX, y: bottomY))
            path.addLine(to: CGPoint(x: startX, y: bottomY))
            path.addLine(to: CGPoint(x: startX, y: topY))
        } else {
            path.append(UIBezierPath(rect: rect))
        }
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
}
