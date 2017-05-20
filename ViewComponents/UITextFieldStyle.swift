//
//  UITextFieldStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UITextFieldStyle: HashableConcreteStyle {
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
    
    public func sideEffect(on view: UITextField) {
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
    
    public static func == (lhs: UITextFieldStyle, rhs: UITextFieldStyle) -> Bool {
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
    
    @inline(__always) static func startIndex() -> Int {
        return UICollectionViewStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 18
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .text(value):
            return (1, value?.hashValue ?? 0)
        case let .attributedText(value):
            return (2, value?.hashValue ?? 0)
        case let .placeholder(value):
            return (3, value?.hashValue ?? 0)
        case let .attributedPlaceholder(value):
            return (4, value?.hashValue ?? 0)
        case let .font(value):
            return (5, value.hashValue)
        case let .textColor(value):
            return (6, value.hashValue)
        case let .textAlignment(value):
            return (7, value.hashValue)
        case let .adjustsFontSizeToFitWidth(value):
            return (8, value.hashValue)
        case let .minimumFontSize(value):
            return (9, value.hashValue)
        case let .clearsOnBeginEditing(value):
            return (10, value.hashValue)
        case let .clearsOnInsertion(value):
            return (11, value.hashValue)
        case let .allowsEditingTextAttributes(value):
            return (12, value.hashValue)
        case let .borderStyle(value):
            return (13, value.hashValue)
        case let .background(value):
            return (14, value?.hashValue ?? 0)
        case let .disabledBackground(value):
            return (15, value?.hashValue ?? 0)
        case let .clearButtonMode(value):
            return (16, value.hashValue)
        case let .leftViewMode(value):
            return (17, value.hashValue)
        case let .rightViewMode(value):
            return (18, value.hashValue)
        }
    }
}

public extension Component where T: UITextField {
    public func textField(_ styles: UITextFieldStyle...) -> Component<T> {
        return adding(styles: styles)
    }
}
