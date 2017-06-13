//
//  UITextViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UITextViewStyleKey: Int, Hashable {
    case text = 170, attributedText, font
    case textColor, isEditable, allowsEditingTextAttributes
    case dataDetectorTypes, textAlignment, textContainerInset
    case selectedRange, clearsOnInsertion, isSelectable
}

public enum UITextViewStyle<T: UITextView>: KeyedStyle {
    public typealias Key = UITextViewStyleKey
    
    case text(String)
    case attributedText(NSAttributedString)
    case font(UIFont?)
    case textColor(UIColor?)
    case isEditable(Bool)
    case allowsEditingTextAttributes(Bool)
    case dataDetectorTypes(UIDataDetectorTypes)
    case textAlignment(NSTextAlignment)
    case textContainerInset(UIEdgeInsets)
    case selectedRange(NSRange)
    case clearsOnInsertion(Bool)
    case isSelectable(Bool)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .text(value):
            view.text = value
        case let .attributedText(value):
            view.attributedText = value
        case let .font(value):
            view.font = value
        case let .textColor(value):
            view.textColor = value
        case let .isEditable(value):
            view.isEditable = value
        case let .allowsEditingTextAttributes(value):
            view.allowsEditingTextAttributes = value
        case let .dataDetectorTypes(value):
            view.dataDetectorTypes = value
        case let .textAlignment(value):
            view.textAlignment = value
        case let .textContainerInset(value):
            view.textContainerInset = value
        case let .selectedRange(value):
            view.selectedRange = value
        case let .clearsOnInsertion(value):
            view.clearsOnInsertion = value
        case let .isSelectable(value):
            view.isSelectable = value
        }
    }
    
    public static func == (lhs: UITextViewStyle<T>, rhs: UITextViewStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.text(left), .text(right)):
            return left == right
        case let (.attributedText(left), .attributedText(right)):
            return left == right
        case let (.font(left), .font(right)):
            return left == right
        case let (.textColor(left), .textColor(right)):
            return left == right
        case let (.isEditable(left), .isEditable(right)),
             let (.allowsEditingTextAttributes(left), .allowsEditingTextAttributes(right)),
             let (.clearsOnInsertion(left), .clearsOnInsertion(right)),
             let (.isSelectable(left), .isSelectable(right)):
            return left == right
        case let (.dataDetectorTypes(left), .dataDetectorTypes(right)):
            return left == right
        case let (.textAlignment(left), .textAlignment(right)):
            return left == right
        case let (.textContainerInset(left), .textContainerInset(right)):
            return left == right
        case let (.selectedRange(left), .selectedRange(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .text(value):
            return (.text, value.hashValue)
        case let .attributedText(value):
            return (.attributedText, value.hashValue)
        case let .font(value):
            return (.font, value?.hashValue ?? 0)
        case let .textColor(value):
            return (.textColor, value?.hashValue ?? 0)
        case let .isEditable(value):
            return (.isEditable, value.hashValue)
        case let .allowsEditingTextAttributes(value):
            return (.allowsEditingTextAttributes, value.hashValue)
        case let .dataDetectorTypes(value):
            return (.dataDetectorTypes, value.rawValue.hashValue)
        case let .textAlignment(value):
            return (.textAlignment, value.hashValue)
        case let .textContainerInset(value):
            return (.textContainerInset, value.hashValue)
        case let .selectedRange(value):
            return (.selectedRange, value.hashValue)
        case let .clearsOnInsertion(value):
            return (.clearsOnInsertion, value.hashValue)
        case let .isSelectable(value):
            return (.isSelectable, value.hashValue)
        }
    }
}

public extension Component where T: UITextView {
    public func textView(_ styles: UITextViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
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

