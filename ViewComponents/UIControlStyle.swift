//
//  UIControlStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIControlStyle<T: UIControl>: KeyedStyle {
    public enum Key: Int, Hashable {
        case isEnabled = 60, isSelected, isHighlighted
        case contentVerticalAlignment, contentHorizontalAlignment
    }
    
    case isEnabled(Bool)
    case isSelected(Bool)
    case isHighlighted(Bool)
    case contentVerticalAlignment(UIControlContentVerticalAlignment)
    case contentHorizontalAlignment(UIControlContentHorizontalAlignment)
    
    public func sideEffect(on view: T) {
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
    
    public static func == (lhs: UIControlStyle<T>, rhs: UIControlStyle<T>) -> Bool {
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
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .isEnabled(isEnabled):
            return (.isEnabled, isEnabled.hashValue)
        case let .isSelected(isSelected):
            return (.isSelected, isSelected.hashValue)
        case let .isHighlighted(isHighlighted):
            return (.isHighlighted, isHighlighted.hashValue)
        case let .contentVerticalAlignment(alignment):
            return (.contentVerticalAlignment, alignment.hashValue)
        case let .contentHorizontalAlignment(alignment):
            return (.contentHorizontalAlignment, alignment.hashValue)
        }
    }
}

public extension Component where T: UIControl {
    public func control(_ styles: UIControlStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
