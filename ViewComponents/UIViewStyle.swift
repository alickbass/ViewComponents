//
//  UIViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIViewStyle<T: UIView> {
    public enum Key: Int, Hashable {
        case backgroundColor = 32, isHidden, alpha
        case isOpaque, tintColor, tintAdjustmentMode
        case clipsToBounds, clearsContextBeforeDrawing, isUserInteractionEnabled
        case isMultipleTouchEnabled, isExclusiveTouch, contentMode
    }
    
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

extension UIViewStyle: KeyedStyle {
    public func sideEffect(on view: T) {
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
    
    public static func == (lhs: UIViewStyle<T>, rhs: UIViewStyle<T>) -> Bool {
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
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .backgroundColor(color):
            return (.backgroundColor, color?.hashValue ?? 0)
        case let .isHidden(isHidden):
            return (.isHidden, isHidden.hashValue)
        case let .alpha(alpha):
            return (.alpha, alpha.hashValue)
        case let .isOpaque(isOpaque):
            return (.isOpaque, isOpaque.hashValue)
        case let .tintColor(tintColor):
            return (.tintColor, tintColor.hashValue)
        case let .tintAdjustmentMode(mode):
            return (.tintAdjustmentMode, mode.hashValue)
        case let .clipsToBounds(clips):
            return (.clipsToBounds, clips.hashValue)
        case let .clearsContextBeforeDrawing(clears):
            return (.clearsContextBeforeDrawing, clears.hashValue)
        case let .isUserInteractionEnabled(isEnabled):
            return (.isUserInteractionEnabled, isEnabled.hashValue)
        case let .isMultipleTouchEnabled(isEnabled):
            return (.isMultipleTouchEnabled, isEnabled.hashValue)
        case let .isExclusiveTouch(isExclusive):
            return (.isExclusiveTouch, isExclusive.hashValue)
        case let .contentMode(mode):
            return (.contentMode, mode.hashValue)
        }
    }
}

public extension Component where T: UIView {
    public func view(_ styles: UIViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
