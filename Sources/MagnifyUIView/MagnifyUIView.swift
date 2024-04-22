//
//  MagnifyView.swift
//  MagnifyUI
//
//  Created by Vikash Kumar on 29/03/24.
//

import Foundation
import UIKit

public class MagnifyView: UIView {
    var viewToMagnify: UIView!
    var touchPoint: CGPoint!
    var context: CGContext?
    
    var boarderColor: UIColor? {
        didSet {
            setBorderColor()
        }
    }
    
    var boarderWidth: CGFloat? {
        didSet {
            setBorderWidth()
        }
    }
    
    func setBorderColor() {
        self.layer.borderColor = boarderColor?.cgColor
    }
    
    func setBorderWidth() {
        self.layer.borderWidth = boarderWidth ?? 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.isUserInteractionEnabled = false
        // set border color, border width and corner radius of the magnify view
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = true
    }
    
    func setTouchPoint(pt: CGPoint) {
        touchPoint = pt
        self.center = CGPoint(x: pt.x, y: pt.y - 10)
    }
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.translateBy(x: 1 * (self.frame.size.width * 0.5), y: 1 * (self.frame.size.height * 0.5))
        context.scaleBy(x: 1.5, y: 1.5) // 1.5 is the zoom scale
        context.translateBy(x: -1 * (touchPoint.x), y: -1 * (touchPoint.y))
        removeFromSuperview()
        self.viewToMagnify.layer.render(in: context)
        self.viewToMagnify.addSubview(self)
        
    }
}
