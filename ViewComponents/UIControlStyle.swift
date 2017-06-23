//
//  UIControlStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UIControlStyleKey: Int, StyleKey {
    case isEnabled = 150, isSelected, isHighlighted
    case contentVerticalAlignment, contentHorizontalAlignment
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
