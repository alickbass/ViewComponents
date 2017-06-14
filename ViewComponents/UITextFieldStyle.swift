//
//  UITextFieldStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UITextFieldStyleKey: Int, Hashable {
    case text = 152, attributedText, placeholder
    case attributedPlaceholder, font, textColor
    case textAlignment, adjustsFontSizeToFitWidth, minimumFontSize
    case clearsOnBeginEditing, clearsOnInsertion, allowsEditingTextAttributes
    case borderStyle, background, disabledBackground
    case clearButtonMode, leftViewMode, rightViewMode
}

public extension AnyStyle where T: UITextField {
    private typealias ViewStyle<Item> = Style<T, Item, UITextFieldStyleKey>
    
    public static func text(_ value: String?) -> AnyStyle<T> {
        return ViewStyle(value, key: .text, sideEffect: { $0.text = $1 }).toAnyStyle
    }
    
    public static func attributedText(_ value: NSAttributedString?) -> AnyStyle<T> {
        return ViewStyle(value, key: .attributedText, sideEffect: { $0.attributedText = $1 }).toAnyStyle
    }
    
    public static func placeholder(_ value: String?) -> AnyStyle<T> {
        return ViewStyle(value, key: .placeholder, sideEffect: { $0.placeholder = $1 }).toAnyStyle
    }
    
    public static func attributedPlaceholder(_ value: NSAttributedString?) -> AnyStyle<T> {
        return ViewStyle(value, key: .attributedPlaceholder, sideEffect: { $0.attributedPlaceholder = $1 }).toAnyStyle
    }
    
    public static func font(_ value: UIFont) -> AnyStyle<T> {
        return ViewStyle(value, key: .font, sideEffect: { $0.font = $1 }).toAnyStyle
    }
    
    public static func textColor(_ value: UIColor) -> AnyStyle<T> {
        return ViewStyle(value, key: .textColor, sideEffect: { $0.textColor = $1 }).toAnyStyle
    }
    
    public static func textAlignment(_ value: NSTextAlignment) -> AnyStyle<T> {
        return ViewStyle(value, key: .textAlignment, sideEffect: { $0.textAlignment = $1 }).toAnyStyle
    }
    
    public static func adjustsFontSizeToFitWidth(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .adjustsFontSizeToFitWidth, sideEffect: { $0.adjustsFontSizeToFitWidth = $1 }).toAnyStyle
    }
    
    public static func minimumFontSize(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .minimumFontSize, sideEffect: { $0.minimumFontSize = $1 }).toAnyStyle
    }
    
    public static func clearsOnBeginEditing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .clearsOnBeginEditing, sideEffect: { $0.clearsOnBeginEditing = $1 }).toAnyStyle
    }
    
    public static func clearsOnInsertion(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .clearsOnInsertion, sideEffect: { $0.clearsOnInsertion = $1 }).toAnyStyle
    }
    
    public static func allowsEditingTextAttributes(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsEditingTextAttributes, sideEffect: { $0.allowsEditingTextAttributes = $1 }).toAnyStyle
    }
    
    public static func borderStyle(_ value: UITextBorderStyle) -> AnyStyle<T> {
        return ViewStyle(value, key: .borderStyle, sideEffect: { $0.borderStyle = $1 }).toAnyStyle
    }
    
    public static func background(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .background, sideEffect: { $0.background = $1 }).toAnyStyle
    }
    
    public static func disabledBackground(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .disabledBackground, sideEffect: { $0.disabledBackground = $1 }).toAnyStyle
    }
    
    public static func clearButtonMode(_ value: UITextFieldViewMode) -> AnyStyle<T> {
        return ViewStyle(value, key: .clearButtonMode, sideEffect: { $0.clearButtonMode = $1 }).toAnyStyle
    }
    
    public static func leftViewMode(_ value: UITextFieldViewMode) -> AnyStyle<T> {
        return ViewStyle(value, key: .leftViewMode, sideEffect: { $0.leftViewMode = $1 }).toAnyStyle
    }
    
    public static func rightViewMode(_ value: UITextFieldViewMode) -> AnyStyle<T> {
        return ViewStyle(value, key: .rightViewMode, sideEffect: { $0.rightViewMode = $1 }).toAnyStyle
    }
}
