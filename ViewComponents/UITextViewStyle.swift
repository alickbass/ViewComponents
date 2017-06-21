//
//  UITextViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UITextViewStyleKey: Int, Hashable {
    case text = 550, attributedText, font
    case textColor, isEditable, allowsEditingTextAttributes
    case dataDetectorTypes, textAlignment, textContainerInset
    case selectedRange, clearsOnInsertion, isSelectable
}

public extension AnyStyle where T: UITextView {
    private typealias ViewStyle<Item> = Style<T, Item, UITextViewStyleKey>
    
    public static func text(_ value: String?) -> AnyStyle<T> {
        return ViewStyle(value, key: .text, sideEffect: { $0.text = $1 }).toAnyStyle
    }
    
    public static func attributedText(_ value: NSAttributedString?) -> AnyStyle<T> {
        return ViewStyle(value, key: .attributedText, sideEffect: { $0.attributedText = $1 }).toAnyStyle
    }
    
    public static func font(_ value: UIFont) -> AnyStyle<T> {
        return ViewStyle(value, key: .font, sideEffect: { $0.font = $1 }).toAnyStyle
    }
    
    public static func textColor(_ value: UIColor) -> AnyStyle<T> {
        return ViewStyle(value, key: .textColor, sideEffect: { $0.textColor = $1 }).toAnyStyle
    }
    
    public static func isEditable(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isEditable, sideEffect: { $0.isEditable = $1 }).toAnyStyle
    }
    
    public static func allowsEditingTextAttributes(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsEditingTextAttributes, sideEffect: { $0.allowsEditingTextAttributes = $1 }).toAnyStyle
    }
    
    public static func dataDetectorTypes(_ value: UIDataDetectorTypes) -> AnyStyle<T> {
        return ViewStyle(value, key: .dataDetectorTypes, sideEffect: { $0.dataDetectorTypes = $1 }).toAnyStyle
    }
    
    public static func textAlignment(_ value: NSTextAlignment) -> AnyStyle<T> {
        return ViewStyle(value, key: .textAlignment, sideEffect: { $0.textAlignment = $1 }).toAnyStyle
    }
    
    public static func textContainerInset(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .textContainerInset, sideEffect: { $0.textContainerInset = $1 }).toAnyStyle
    }
    
    public static func selectedRange(_ value: NSRange) -> AnyStyle<T> {
        return ViewStyle(value, key: .selectedRange, sideEffect: { $0.selectedRange = $1 }).toAnyStyle
    }
    
    public static func clearsOnInsertion(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .clearsOnInsertion, sideEffect: { $0.clearsOnInsertion = $1 }).toAnyStyle
    }
    
    public static func isSelectable(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isSelectable, sideEffect: { $0.isSelectable = $1 }).toAnyStyle
    }
}

