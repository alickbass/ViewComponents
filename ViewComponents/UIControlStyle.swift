//
//  UIControlStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIControlStyle: ConcreteStyleType {
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
}
