//
//  UIControlStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIControlStyle: HashableConcreteStyle {
    case isEnabled(Bool)
    case isSelected(Bool)
    case isHighlighted(Bool)
    case contentVerticalAlignment(UIControlContentVerticalAlignment)
    case contentHorizontalAlignment(UIControlContentHorizontalAlignment)
    
    public func sideEffect(on view: UIControl) {
        switch self {
        case let .isEnabled(isEnabled):
            view.isEnabled = isEnabled
        case let .isSelected(isSelected):
            view.isSelected = isSelected
        case let .isHighlighted(isHighlighted):
            view.isHighlighted = isHighlighted
        case let .contentVerticalAlignment(alignment):
            view.contentVerticalAlignment = alignment
        case let .contentHorizontalAlignment(alignment):
            view.contentHorizontalAlignment = alignment
        }
    }
    
    public static func == (lhs: UIControlStyle, rhs: UIControlStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.isEnabled(leftBool), .isEnabled(rightBool)),
             let (.isSelected(leftBool), .isSelected(rightBool)),
             let (.isHighlighted(leftBool), .isHighlighted(rightBool)):
            return leftBool == rightBool
        case let (.contentVerticalAlignment(leftAlignment), .contentVerticalAlignment(rightAlignment)):
            return leftAlignment == rightAlignment
        case let (.contentHorizontalAlignment(leftAlignment), .contentHorizontalAlignment(rightAlignment)):
            return leftAlignment == rightAlignment
        default:
            return false
        }
    }
    
    @inline(__always) static func startIndex() -> Int {
        return UILabelStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 5
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .isEnabled(isEnabled):
            return (1, isEnabled.hashValue)
        case let .isSelected(isSelected):
            return (2, isSelected.hashValue)
        case let .isHighlighted(isHighlighted):
            return (3, isHighlighted.hashValue)
        case let .contentVerticalAlignment(alignment):
            return (4, alignment.hashValue)
        case let .contentHorizontalAlignment(alignment):
            return (5, alignment.hashValue)
        }
    }
}

public extension Component where T: UIControl {
    public func control(_ styles: UIControlStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
