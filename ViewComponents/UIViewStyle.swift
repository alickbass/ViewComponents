//
//  UIViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIViewStyle {
    case backgroundColor(UIColor?)
    case isHidden(Bool)
    case alpha(CGFloat)
    case isOpaque(Bool)
    case tintColor(UIColor)
    case tintAdjustmentMode(UIViewTintAdjustmentMode)
    case clipsToBounds(Bool)
    case clearsContextBeforeDrawing(Bool)
    case isUserInteractionEnabled(Bool)
    case isMultipleTouchEnabled(Bool)
    case isExclusiveTouch(Bool)
    case contentMode(UIViewContentMode)
}

extension UIViewStyle: HashableConcreteStyle {
    public typealias View = UIView
    
    public func sideEffect(on view: UIView) {
        switch self {
        case let .backgroundColor(color):
            view.backgroundColor = color
        case let .isHidden(isHidden):
            view.isHidden = isHidden
        case let .alpha(alpha):
            view.alpha = alpha
        case let .isOpaque(isOpaque):
            view.isOpaque = isOpaque
        case let .tintColor(tintColor):
            view.tintColor = tintColor
        case let .tintAdjustmentMode(mode):
            view.tintAdjustmentMode = mode
        case let .clipsToBounds(clips):
            view.clipsToBounds = clips
        case let .clearsContextBeforeDrawing(clears):
            view.clearsContextBeforeDrawing = clears
        case let .isUserInteractionEnabled(isEnabled):
            view.isUserInteractionEnabled = isEnabled
        case let .isMultipleTouchEnabled(isEnabled):
            view.isMultipleTouchEnabled = isEnabled
        case let .isExclusiveTouch(isExclusive):
            view.isExclusiveTouch = isExclusive
        case let .contentMode(mode):
            view.contentMode = mode
        }
    }
    
    public static func == (lhs: UIViewStyle, rhs: UIViewStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.backgroundColor(leftColor), .backgroundColor(rightColor)):
            return leftColor == rightColor
        case let (.alpha(leftAlpha), .alpha(rightAlpha)):
            return leftAlpha == rightAlpha
        case let (.isHidden(leftBool), .isHidden(rightBool)),
             let (.isOpaque(leftBool), .isOpaque(rightBool)),
             let (.clipsToBounds(leftBool), .clipsToBounds(rightBool)),
             let (.clearsContextBeforeDrawing(leftBool), .clearsContextBeforeDrawing(rightBool)),
             let (.isUserInteractionEnabled(leftBool), .isUserInteractionEnabled(rightBool)),
             let (.isMultipleTouchEnabled(leftBool), .isMultipleTouchEnabled(rightBool)),
             let (.isExclusiveTouch(leftBool), .isExclusiveTouch(rightBool)):
            return leftBool == rightBool
        case let (.tintColor(leftColor), .tintColor(rightColor)):
            return leftColor == rightColor
        case let (.tintAdjustmentMode(leftMode), .tintAdjustmentMode(rightMode)):
            return leftMode == rightMode
        case let (.contentMode(leftMode), .contentMode(rightMode)):
            return leftMode == rightMode
        default:
            return false
        }
    }
    
    @inline(__always) static func startIndex() -> Int {
        return CALayer.BorderStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 12
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .backgroundColor(color):
            return (1, color?.hashValue ?? 0)
        case let .isHidden(isHidden):
            return (2, isHidden.hashValue)
        case let .alpha(alpha):
            return (3, alpha.hashValue)
        case let .isOpaque(isOpaque):
            return (4, isOpaque.hashValue)
        case let .tintColor(tintColor):
            return (5, tintColor.hashValue)
        case let .tintAdjustmentMode(mode):
            return (6, mode.hashValue)
        case let .clipsToBounds(clips):
            return (7, clips.hashValue)
        case let .clearsContextBeforeDrawing(clears):
            return (8, clears.hashValue)
        case let .isUserInteractionEnabled(isEnabled):
            return (9, isEnabled.hashValue)
        case let .isMultipleTouchEnabled(isEnabled):
            return (10, isEnabled.hashValue)
        case let .isExclusiveTouch(isExclusive):
            return (11, isExclusive.hashValue)
        case let .contentMode(mode):
            return (12, mode.hashValue)
        }
    }
}

public extension Component where T: UIView {
    public func view(_ styles: UIViewStyle...) -> Component<T> {
        return adding(styles: styles)
    }
}
