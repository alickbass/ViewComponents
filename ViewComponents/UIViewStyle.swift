//
//  UIViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UIViewStyleKey: Int, Hashable {
    case backgroundColor = 32, isHidden, alpha
    case isOpaque, tintColor, tintAdjustmentMode
    case clipsToBounds, clearsContextBeforeDrawing, isUserInteractionEnabled
    case isMultipleTouchEnabled, isExclusiveTouch, contentMode, layoutMargins
    case preservesSuperviewLayoutMargins
}

public extension AnyStyle where T: UIView {
    private typealias ViewStyle<Item> = Style<T, Item, UIViewStyleKey>
    
    public static func backgroundColor(_ color: UIColor? = nil) -> AnyStyle<T> {
        return ViewStyle(color, key: .backgroundColor, sideEffect: { $0.0.backgroundColor = $0.1 }).toAnyStyle
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
    
    public static func layoutMargins(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .layoutMargins, sideEffect: { $0.layoutMargins = $1 }).toAnyStyle
    }
    
    public static func preservesSuperviewLayoutMargins(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .preservesSuperviewLayoutMargins, sideEffect: { $0.preservesSuperviewLayoutMargins = $1 }).toAnyStyle
    }
}
