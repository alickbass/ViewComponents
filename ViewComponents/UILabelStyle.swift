//
//  UILabelStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 30/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UILabelStyleKey: Int, Hashable {
    case text = 44, attributedText, font
    case textColor, textAlignment, lineBreakMode
    case isEnabled, adjustsFontSizeToFitWidth, allowsDefaultTighteningForTruncation
    case baselineAdjustment, minimumScaleFactor, numberOfLines
    case highlightedTextColor, isHighlighted, shadowColor
    case shadowOffset
}

public extension AnyStyle where T: UILabel {
    private typealias ViewStyle<Item> = Style<T, Item, UILabelStyleKey>
    
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
    
    public static func textAlignment(_ value: NSTextAlignment) -> AnyStyle<T> {
        return ViewStyle(value, key: .textAlignment, sideEffect: { $0.textAlignment = $1 }).toAnyStyle
    }
    
    public static func lineBreakMode(_ value: NSLineBreakMode) -> AnyStyle<T> {
        return ViewStyle(value, key: .lineBreakMode, sideEffect: { $0.lineBreakMode = $1 }).toAnyStyle
    }
    
    public static func isEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isEnabled, sideEffect: { $0.isEnabled = $1 }).toAnyStyle
    }
    
    public static func adjustsFontSizeToFitWidth(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .adjustsFontSizeToFitWidth, sideEffect: { $0.adjustsFontSizeToFitWidth = $1 }).toAnyStyle
    }
    
    public static func allowsDefaultTighteningForTruncation(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsDefaultTighteningForTruncation, sideEffect: { $0.allowsDefaultTighteningForTruncation = $1 }).toAnyStyle
    }
    
    public static func baselineAdjustment(_ value: UIBaselineAdjustment) -> AnyStyle<T> {
        return ViewStyle(value, key: .baselineAdjustment, sideEffect: { $0.baselineAdjustment = $1 }).toAnyStyle
    }
    
    public static func minimumScaleFactor(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .minimumScaleFactor, sideEffect: { $0.minimumScaleFactor = $1 }).toAnyStyle
    }
    
    public static func numberOfLines(_ value: Int) -> AnyStyle<T> {
        return ViewStyle(value, key: .numberOfLines, sideEffect: { $0.numberOfLines = $1 }).toAnyStyle
    }
    
    public static func highlightedTextColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .highlightedTextColor, sideEffect: { $0.highlightedTextColor = $1 }).toAnyStyle
    }
    
    public static func isHighlighted(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isHighlighted, sideEffect: { $0.isHighlighted = $1 }).toAnyStyle
    }
    
    public static func shadowColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .shadowColor, sideEffect: { $0.shadowColor = $1 }).toAnyStyle
    }
    
    public static func shadowOffset(_ value: CGSize) -> AnyStyle<T> {
        return ViewStyle(value, key: .shadowOffset, sideEffect: { $0.shadowOffset = $1 }).toAnyStyle
    }
}
