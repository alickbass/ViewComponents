//
//  UIControlStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIControlStyleKey: Int, Hashable {
    case isEnabled = 60, isSelected, isHighlighted
    case contentVerticalAlignment, contentHorizontalAlignment
}

public enum UIControlStyle<T: UIControl>: KeyedStyle {
    public typealias Key = UIControlStyleKey
    
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

public extension AnyStyle where T: UIControl {
    private typealias ViewStyle<Item> = Style<T, Item, UIControlStyleKey>
    
    public static func isEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isEnabled, sideEffect: { $0.isEnabled = $1 }).toAnyStyle
    }
    
    public static func isSelected(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isSelected, sideEffect: { $0.isSelected = $1 }).toAnyStyle
    }
    
    public static func isHighlighted(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isHighlighted, sideEffect: { $0.isHighlighted = $1 }).toAnyStyle
    }
    
    public static func contentVerticalAlignment(_ value: UIControlContentVerticalAlignment) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentVerticalAlignment, sideEffect: { $0.contentVerticalAlignment = $1 }).toAnyStyle
    }
    
    public static func contentHorizontalAlignment(_ value: UIControlContentHorizontalAlignment) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentHorizontalAlignment, sideEffect: { $0.contentHorizontalAlignment = $1 }).toAnyStyle
    }
}
