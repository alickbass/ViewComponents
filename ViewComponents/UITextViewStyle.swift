//
//  UITextViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UITextViewStyle<T: UITextView>: KeyedStyle {
    public enum Key: Int, Hashable {
        case text = 170, attributedText, font
        case textColor, isEditable, allowsEditingTextAttributes
        case dataDetectorTypes, textAlignment, textContainerInset
        case selectedRange, clearsOnInsertion, isSelectable
    }
    
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
