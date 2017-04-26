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
}

extension UIViewStyle: ConcreteStyleType {
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
        default:
            return false
        }
    }
}

public extension Component {
    public func viewStyles(_ styles: UIViewStyle...) -> Component<T> {
        return Component<T>(styles: self.styles + styles, children: children)
    }
}
