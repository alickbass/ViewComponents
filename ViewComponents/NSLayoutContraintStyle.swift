//
//  NSLayoutContraintStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum NSLayoutConstraintKey: Int, StyleKey {
    case isActive = 800, constant, priority, identifier, shouldBeArchived
}

public extension AnyStyle where T: NSLayoutConstraint {
    private typealias ViewStyle<Item> = Style<T, Item, NSLayoutConstraintKey>
    
    public static func isActive(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isActive, sideEffect: { $0.isActive = $1 }).toAnyStyle
    }
    
    public static func constant(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .constant, sideEffect: { $0.constant = $1 }).toAnyStyle
    }
    
    public static func priority(_ value: UILayoutPriority) -> AnyStyle<T> {
        return ViewStyle(value, key: .priority, sideEffect: { $0.priority = $1 }).toAnyStyle
    }
    
    public static func identifier(_ value: String?) -> AnyStyle<T> {
        return ViewStyle(value, key: .identifier, sideEffect: { $0.identifier = $1 }).toAnyStyle
    }
    
    public static func shouldBeArchived(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .shouldBeArchived, sideEffect: { $0.shouldBeArchived = $1 }).toAnyStyle
    }
}
