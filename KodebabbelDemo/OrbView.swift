//
//  OrbView.swift
//  KodebabbelDemo
//
//  Created by thomsmed on 01/11/2020.
//

import Foundation
import UIKit

protocol OrbViewDelegate {
    func orbViewTapped(_ orbView: OrbView)
}

@IBDesignable
class OrbView: UIView {
    
    private static let lineWidth = CGFloat(5)
    
    var delegate: OrbViewDelegate?
    
    @IBInspectable var color: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // View loaded manually from code
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // View loaded from Storyboard (our color propperty wil have been asigned a value here)
        setupGestureRecognizer()
    }
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = (rect.height < rect.width ? rect.height / 2 : rect.width / 2) - 2 * OrbView.lineWidth
        let circle = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        circle.lineWidth = OrbView.lineWidth
        color?.invers().setStroke()
        circle.stroke()
        
        color?.setFill()
        circle.fill()
    }
    
    private func setupGestureRecognizer() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    @objc
    private func onTap() {
        delegate?.orbViewTapped(self)
    }
}

// MARK: UIColor.invers()
extension UIColor {
    func invers() -> UIColor {
        // Copied from internet lol (https://stackoverflow.com/questions/5893261/how-to-get-inverse-color-from-uicolor)
        
        var alpha: CGFloat = 1.0

        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }

        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }

        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            return UIColor(white: 1.0 - white, alpha: alpha)
        }

        return self
    }
}
