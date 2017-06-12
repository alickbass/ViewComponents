//
//  UIViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIViewStyleKey: Int, Hashable {
    case backgroundColor = 32, isHidden, alpha
    case isOpaque, tintColor, tintAdjustmentMode
    case clipsToBounds, clearsContextBeforeDrawing, isUserInteractionEnabled
    case isMultipleTouchEnabled, isExclusiveTouch, contentMode
}

public enum UIViewStyle<T: UIView> {
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
    public typealias Key = UIViewStyleKey
    
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

public extension AnyStyle where T: UIView {
    private typealias ViewStyle<Item> = Style<T, Item, UIViewStyleKey>
    
    public static func backgroundColor(_ color: UIColor? = nil) -> AnyStyle<T> {
        return ViewStyle(
            color, key: .backgroundColor,
            sideEffect: { $0.0.backgroundColor = $0.1 },
            equality: { $0 == $1 },
            hash: { $0?.hashValue ?? 0 }
        ).toAnyStyle
    }
    
    public static func isHidden(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isHidden, sideEffect: { $0.isHidden = $1 }).toAnyStyle
    }
    
    public static func alpha(_ alpha: CGFloat) -> AnyStyle<T> {
        return ViewStyle(alpha, key: .alpha, sideEffect: { $0.0.alpha = $0.1 }).toAnyStyle
    }
    
    public static func isOpaque(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isOpaque, sideEffect: { $0.isOpaque = $1 }).toAnyStyle
    }
    
    public static func tintColor(_ color: UIColor) -> AnyStyle<T> {
        return ViewStyle(color, key: .tintColor, sideEffect: { $0.tintColor = $1 }).toAnyStyle
    }
    
    public static func tintAdjustmentMode(_ mode: UIViewTintAdjustmentMode) -> AnyStyle<T> {
        return ViewStyle(mode, key: .tintAdjustmentMode, sideEffect: { $0.tintAdjustmentMode = $1 }).toAnyStyle
    }
    
    public static func clipsToBounds(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .clipsToBounds, sideEffect: { $0.clipsToBounds = $1 }).toAnyStyle
    }
    
    public static func clearsContextBeforeDrawing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .clearsContextBeforeDrawing, sideEffect: { $0.clearsContextBeforeDrawing = $1 }).toAnyStyle
    }
    
    public static func isUserInteractionEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isUserInteractionEnabled, sideEffect: { $0.isUserInteractionEnabled = $1 }).toAnyStyle
    }
    
    public static func isMultipleTouchEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isMultipleTouchEnabled, sideEffect: { $0.isMultipleTouchEnabled = $1 }).toAnyStyle
    }
    
    public static func isExclusiveTouch(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isExclusiveTouch, sideEffect: { $0.isExclusiveTouch = $1 }).toAnyStyle
    }
    
    public static func contentMode(_ mode: UIViewContentMode) -> AnyStyle<T> {
        return ViewStyle(mode, key: .contentMode, sideEffect: { $0.contentMode = $1 }).toAnyStyle
    }
}
