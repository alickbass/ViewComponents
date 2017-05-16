//
//  UITableViewCellStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum TableViewCellStyle: HashableConcreteStyle {
    case accessoryType(UITableViewCellAccessoryType)
    case editingAccessoryType(UITableViewCellAccessoryType)
    case isSelected(Bool)
    case selectionStyle(UITableViewCellSelectionStyle)
    case isHighlighted(Bool)
    case isEditing(Bool)
    case showsReorderControl(Bool)
    case indentationLevel(Int)
    case indentationWidth(CGFloat)
    case shouldIndentWhileEditing(Bool)
    case separatorInset(UIEdgeInsets)
    case focusStyle(UITableViewCellFocusStyle)

    public func sideEffect(on view: UITableViewCell) {
        switch self {
        case let .accessoryType(value):
            view.accessoryType = value
        case let .editingAccessoryType(value):
            view.editingAccessoryType = value
        case let .isSelected(value):
            view.isSelected = value
        case let .selectionStyle(value):
            view.selectionStyle = value
        case let .isHighlighted(value):
            view.isHighlighted = value
        case let .isEditing(value):
            view.isEditing = value
        case let .showsReorderControl(value):
            view.showsReorderControl = value
        case let .indentationLevel(value):
            view.indentationLevel = value
        case let .indentationWidth(value):
            view.indentationWidth = value
        case let .shouldIndentWhileEditing(value):
            view.shouldIndentWhileEditing = value
        case let .separatorInset(value):
            view.separatorInset = value
        case let .focusStyle(value):
            view.focusStyle = value
        }
    }
    
    public static func == (lhs: TableViewCellStyle, rhs: TableViewCellStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.accessoryType(left), .accessoryType(right)),
             let (.editingAccessoryType(left), .editingAccessoryType(right)):
            return left == right
        case let (.isSelected(left), .isSelected(right)),
             let (.isHighlighted(left), .isHighlighted(right)),
             let (.isEditing(left), .isEditing(right)),
             let (.showsReorderControl(left), .showsReorderControl(right)),
             let (.shouldIndentWhileEditing(left), .shouldIndentWhileEditing(right)):
            return left == right
        case let (.selectionStyle(left), .selectionStyle(right)):
            return left == right
        case let (.indentationLevel(left), .indentationLevel(right)):
            return left == right
        case let (.indentationWidth(left), .indentationWidth(right)):
            return left == right
        case let (.separatorInset(left), .separatorInset(right)):
            return left == right
        case let (.focusStyle(left), .focusStyle(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) static func startIndex() -> Int {
        return TableViewStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 12
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .accessoryType(value):
            return (1, value.hashValue)
        case let .editingAccessoryType(value):
            return (2, value.hashValue)
        case let .isSelected(value):
            return (3, value.hashValue)
        case let .selectionStyle(value):
            return (4, value.hashValue)
        case let .isHighlighted(value):
            return (5, value.hashValue)
        case let .isEditing(value):
            return (6, value.hashValue)
        case let .showsReorderControl(value):
            return (7, value.hashValue)
        case let .indentationLevel(value):
            return (8, value.hashValue)
        case let .indentationWidth(value):
            return (9, value.hashValue)
        case let .shouldIndentWhileEditing(value):
            return (10, value.hashValue)
        case let .separatorInset(value):
            return (11, value.hashValue)
        case let .focusStyle(value):
            return (12, value.hashValue)
        }
    }
}

public extension Component where T: UITableViewCell {
    public func tableViewCell(_ styles: TableViewCellStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
