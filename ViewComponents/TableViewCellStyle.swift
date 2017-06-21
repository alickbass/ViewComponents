//
//  UITableViewCellStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum TableViewCellStyleKey: Int, Hashable {
    case accessoryType = 400, editingAccessoryType, isSelected
    case selectionStyle, isHighlighted, isEditing
    case showsReorderControl, indentationLevel, indentationWidth
    case shouldIndentWhileEditing, separatorInset, focusStyle
}

public extension AnyStyle where T: UITableViewCell {
    private typealias ViewStyle<Item> = Style<T, Item, TableViewCellStyleKey>
    
    public static func accessoryType(_ value: UITableViewCellAccessoryType) -> AnyStyle<T> {
        return ViewStyle(value, key: .accessoryType, sideEffect: { $0.accessoryType = $1 }).toAnyStyle
    }
    
    public static func editingAccessoryType(_ value: UITableViewCellAccessoryType) -> AnyStyle<T> {
        return ViewStyle(value, key: .editingAccessoryType, sideEffect: { $0.editingAccessoryType = $1 }).toAnyStyle
    }
    
    public static func isSelected(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isSelected, sideEffect: { $0.isSelected = $1 }).toAnyStyle
    }
    
    public static func selectionStyle(_ value: UITableViewCellSelectionStyle) -> AnyStyle<T> {
        return ViewStyle(value, key: .selectionStyle, sideEffect: { $0.selectionStyle = $1 }).toAnyStyle
    }
    
    public static func isHighlighted(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isHighlighted, sideEffect: { $0.isHighlighted = $1 }).toAnyStyle
    }
    
    public static func isEditing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isEditing, sideEffect: { $0.isEditing = $1 }).toAnyStyle
    }
    
    public static func showsReorderControl(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .showsReorderControl, sideEffect: { $0.showsReorderControl = $1 }).toAnyStyle
    }
    
    public static func indentationLevel(_ value: Int) -> AnyStyle<T> {
        return ViewStyle(value, key: .indentationLevel, sideEffect: { $0.indentationLevel = $1 }).toAnyStyle
    }
    
    public static func indentationWidth(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .indentationWidth, sideEffect: { $0.indentationWidth = $1 }).toAnyStyle
    }
    
    public static func shouldIndentWhileEditing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .shouldIndentWhileEditing, sideEffect: { $0.shouldIndentWhileEditing = $1 }).toAnyStyle
    }
    
    public static func separatorInset(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .separatorInset, sideEffect: { $0.separatorInset = $1 }).toAnyStyle
    }
    
    public static func focusStyle(_ value: UITableViewCellFocusStyle) -> AnyStyle<T> {
        return ViewStyle(value, key: .focusStyle, sideEffect: { $0.focusStyle = $1 }).toAnyStyle
    }
}
