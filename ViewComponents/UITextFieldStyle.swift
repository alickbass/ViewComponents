//
//  UITextFieldStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UITextFieldStyle<T: UITextField>: KeyedStyle {
    public enum Key: Int, Hashable {
        case text = 152, attributedText, placeholder
        case attributedPlaceholder, font, textColor
        case textAlignment, adjustsFontSizeToFitWidth, minimumFontSize
        case clearsOnBeginEditing, clearsOnInsertion, allowsEditingTextAttributes
        case borderStyle, background, disabledBackground
        case clearButtonMode, leftViewMode, rightViewMode
    }
    
    case text(String?)
    case attributedText(NSAttributedString?)
    case placeholder(String?)
    case attributedPlaceholder(NSAttributedString?)
    case font(UIFont)
    case textColor(UIColor)
    case textAlignment(NSTextAlignment)
    case adjustsFontSizeToFitWidth(Bool)
    case minimumFontSize(CGFloat)
    case clearsOnBeginEditing(Bool)
    case clearsOnInsertion(Bool)
    case allowsEditingTextAttributes(Bool)
    case borderStyle(UITextBorderStyle)
    case background(UIImage?)
    case disabledBackground(UIImage?)
    case clearButtonMode(UITextFieldViewMode)
    case leftViewMode(UITextFieldViewMode)
    case rightViewMode(UITextFieldViewMode)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .text(value):
            view.text = value
        case let .attributedText(value):
            view.attributedText = value
        case let .placeholder(value):
            view.placeholder = value
        case let .attributedPlaceholder(value):
            view.attributedPlaceholder = value
        case let .font(value):
            view.font = value
        case let .textColor(value):
            view.textColor = value
        case let .textAlignment(value):
            view.textAlignment = value
        case let .adjustsFontSizeToFitWidth(value):
            view.adjustsFontSizeToFitWidth = value
        case let .minimumFontSize(value):
            view.minimumFontSize = value
        case let .clearsOnBeginEditing(value):
            view.clearsOnBeginEditing = value
        case let .clearsOnInsertion(value):
            view.clearsOnInsertion = value
        case let .allowsEditingTextAttributes(value):
            view.allowsEditingTextAttributes = value
        case let .borderStyle(value):
            view.borderStyle = value
        case let .background(value):
            view.background = value
        case let .disabledBackground(value):
            view.disabledBackground = value
        case let .clearButtonMode(value):
            view.clearButtonMode = value
        case let .leftViewMode(value):
            view.leftViewMode = value
        case let .rightViewMode(value):
            view.rightViewMode = value
        }
    }
    
    public static func == (lhs: UITextFieldStyle<T>, rhs: UITextFieldStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.text(left), .text(right)),
             let (.placeholder(left), .placeholder(right)):
            return left == right
        case let (.attributedText(left), .attributedText(right)),
             let (.attributedPlaceholder(left), .attributedPlaceholder(right)):
            return left == right
        case let (.font(left), .font(right)):
            return left == right
        case let (.textColor(left), .textColor(right)):
            return left == right
        case let (.textAlignment(left), .textAlignment(right)):
            return left == right
        case let (.adjustsFontSizeToFitWidth(left), .adjustsFontSizeToFitWidth(right)),
             let (.clearsOnBeginEditing(left), .clearsOnBeginEditing(right)),
             let (.clearsOnInsertion(left), .clearsOnInsertion(right)),
             let (.allowsEditingTextAttributes(left), .allowsEditingTextAttributes(right)):
            return left == right
        case let (.minimumFontSize(left), .minimumFontSize(right)):
            return left == right
        case let (.borderStyle(left), .borderStyle(right)):
            return left == right
        case let (.background(left), .background(right)),
             let (.disabledBackground(left), .disabledBackground(right)):
            return left == right
        case let (.clearButtonMode(left), .clearButtonMode(right)),
             let (.leftViewMode(left), .leftViewMode(right)),
             let (.rightViewMode(left), .rightViewMode(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .text(value):
            return (.text, value?.hashValue ?? 0)
        case let .attributedText(value):
            return (.attributedText, value?.hashValue ?? 0)
        case let .placeholder(value):
            return (.placeholder, value?.hashValue ?? 0)
        case let .attributedPlaceholder(value):
            return (.attributedPlaceholder, value?.hashValue ?? 0)
        case let .font(value):
            return (.font, value.hashValue)
        case let .textColor(value):
            return (.textColor, value.hashValue)
        case let .textAlignment(value):
            return (.textAlignment, value.hashValue)
        case let .adjustsFontSizeToFitWidth(value):
            return (.adjustsFontSizeToFitWidth, value.hashValue)
        case let .minimumFontSize(value):
            return (.minimumFontSize, value.hashValue)
        case let .clearsOnBeginEditing(value):
            return (.clearsOnBeginEditing, value.hashValue)
        case let .clearsOnInsertion(value):
            return (.clearsOnInsertion, value.hashValue)
        case let .allowsEditingTextAttributes(value):
            return (.allowsEditingTextAttributes, value.hashValue)
        case let .borderStyle(value):
            return (.borderStyle, value.hashValue)
        case let .background(value):
            return (.background, value?.hashValue ?? 0)
        case let .disabledBackground(value):
            return (.disabledBackground, value?.hashValue ?? 0)
        case let .clearButtonMode(value):
            return (.clearButtonMode, value.hashValue)
        case let .leftViewMode(value):
            return (.leftViewMode, value.hashValue)
        case let .rightViewMode(value):
            return (.rightViewMode, value.hashValue)
        }
    }
}

public extension Component where T: UITextField {
    public func textField(_ styles: UITextFieldStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
