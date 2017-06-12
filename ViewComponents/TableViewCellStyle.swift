//
//  UITableViewCellStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum TableViewCellStyle<T: UITableViewCell>: KeyedStyle {
    public enum Key: Int, Hashable {
        case accessoryType = 135, editingAccessoryType, isSelected
        case selectionStyle, isHighlighted, isEditing
        case showsReorderControl, indentationLevel, indentationWidth
        case shouldIndentWhileEditing, separatorInset, focusStyle
    }
    
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

    public func sideEffect(on view: T) {
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
    
    public static func == (lhs: TableViewCellStyle<T>, rhs: TableViewCellStyle<T>) -> Bool {
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
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .accessoryType(value):
            return (.accessoryType, value.hashValue)
        case let .editingAccessoryType(value):
            return (.editingAccessoryType, value.hashValue)
        case let .isSelected(value):
            return (.isSelected, value.hashValue)
        case let .selectionStyle(value):
            return (.selectionStyle, value.hashValue)
        case let .isHighlighted(value):
            return (.isHighlighted, value.hashValue)
        case let .isEditing(value):
            return (.isEditing, value.hashValue)
        case let .showsReorderControl(value):
            return (.showsReorderControl, value.hashValue)
        case let .indentationLevel(value):
            return (.indentationLevel, value.hashValue)
        case let .indentationWidth(value):
            return (.indentationWidth, value.hashValue)
        case let .shouldIndentWhileEditing(value):
            return (.shouldIndentWhileEditing, value.hashValue)
        case let .separatorInset(value):
            return (.separatorInset, value.hashValue)
        case let .focusStyle(value):
            return (.focusStyle, value.hashValue)
        }
    }
}

public extension Component where T: UITableViewCell {
    public func tableViewCell(_ styles: TableViewCellStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
