//
//  TableViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum TableViewStyleKey: Int, StyleKey {
    case rowHeight = 350, separatorStyle, separatorColor
    case separatorEffect, separatorInset, cellLayoutMarginsFollowReadableWidth
    case sectionHeaderHeight, sectionFooterHeight, estimatedRowHeight
    case estimatedSectionHeaderHeight, estimatedSectionFooterHeight, allowsSelection
    case allowsMultipleSelection, allowsSelectionDuringEditing, allowsMultipleSelectionDuringEditing
    case isEditing, sectionIndexColor, sectionIndexBackgroundColor
    case sectionIndexTrackingBackgroundColor, remembersLastFocusedIndexPath, dataSource
    case delegate, tableHeaderView, tableFooterView
}

public extension AnyStyle where T: UITableView {
    private typealias ViewStyle<Item> = Style<T, Item, TableViewStyleKey>
    
    public static func rowHeight(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .rowHeight, sideEffect: { $0.rowHeight = $1 }).toAnyStyle
    }
    
    public static func separatorStyle(_ value: UITableViewCellSeparatorStyle) -> AnyStyle<T> {
        return ViewStyle(value, key: .separatorStyle, sideEffect: { $0.separatorStyle = $1 }).toAnyStyle
    }
    
    public static func separatorColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .separatorColor, sideEffect: { $0.separatorColor = $1 }).toAnyStyle
    }
    
    public static func separatorEffect(_ value: UIVisualEffect?) -> AnyStyle<T> {
        return ViewStyle(value, key: .separatorEffect, sideEffect: { $0.separatorEffect = $1 }).toAnyStyle
    }
    
    public static func separatorInset(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .separatorInset, sideEffect: { $0.separatorInset = $1 }).toAnyStyle
    }
    
    public static func cellLayoutMarginsFollowReadableWidth(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .cellLayoutMarginsFollowReadableWidth, sideEffect: { $0.cellLayoutMarginsFollowReadableWidth = $1 }).toAnyStyle
    }
    
    public static func sectionHeaderHeight(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .sectionHeaderHeight, sideEffect: { $0.sectionHeaderHeight = $1 }).toAnyStyle
    }
    
    public static func sectionFooterHeight(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .sectionFooterHeight, sideEffect: { $0.sectionFooterHeight = $1 }).toAnyStyle
    }
    
    public static func estimatedRowHeight(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .estimatedRowHeight, sideEffect: { $0.estimatedRowHeight = $1 }).toAnyStyle
    }
    
    public static func estimatedSectionHeaderHeight(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .estimatedSectionHeaderHeight, sideEffect: { $0.estimatedSectionHeaderHeight = $1 }).toAnyStyle
    }
    
    public static func estimatedSectionFooterHeight(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .estimatedSectionFooterHeight, sideEffect: { $0.estimatedSectionFooterHeight = $1 }).toAnyStyle
    }
    
    public static func allowsSelection(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsSelection, sideEffect: { $0.allowsSelection = $1 }).toAnyStyle
    }
    
    public static func allowsMultipleSelection(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsMultipleSelection, sideEffect: { $0.allowsMultipleSelection = $1 }).toAnyStyle
    }
    
    public static func allowsSelectionDuringEditing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsSelectionDuringEditing, sideEffect: { $0.allowsSelectionDuringEditing = $1 }).toAnyStyle
    }
    
    public static func allowsMultipleSelectionDuringEditing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsMultipleSelectionDuringEditing, sideEffect: { $0.allowsMultipleSelectionDuringEditing = $1 }).toAnyStyle
    }
    
    public static func isEditing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isEditing, sideEffect: { $0.isEditing = $1 }).toAnyStyle
    }
    
    public static func sectionIndexColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .sectionIndexColor, sideEffect: { $0.sectionIndexColor = $1 }).toAnyStyle
    }
    
    public static func sectionIndexBackgroundColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .sectionIndexBackgroundColor, sideEffect: { $0.sectionIndexBackgroundColor = $1 }).toAnyStyle
    }
    
    public static func sectionIndexTrackingBackgroundColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .sectionIndexTrackingBackgroundColor, sideEffect: { $0.sectionIndexTrackingBackgroundColor = $1 }).toAnyStyle
    }
    
    public static func remembersLastFocusedIndexPath(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .remembersLastFocusedIndexPath, sideEffect: { $0.remembersLastFocusedIndexPath = $1 }).toAnyStyle
    }
    
    public static func dataSource(_ value: UITableViewDataSource?) -> AnyStyle<T> {
        return ViewStyle(value, key: .dataSource, sideEffect: { $0.dataSource = $1 }, equality: { $0 === $1 }, hash: { $0?.hash ?? 0 }).toAnyStyle
    }
    
    public static func delegate(_ value: UITableViewDelegate?) -> AnyStyle<T> {
        return ViewStyle(value, key: .delegate, sideEffect: { $0.delegate = $1 }, equality: { $0 === $1 }, hash: { $0?.hash ?? 0 }).toAnyStyle
    }
    
    public static func tableHeaderView(_ value: UIView?) -> AnyStyle<T> {
        return ViewStyle(value, key: .tableHeaderView, sideEffect: { $0.tableHeaderView = $1 }).toAnyStyle
    }
    
    public static func tableFooterView(_ value: UIView?) -> AnyStyle<T> {
        return ViewStyle(value, key: .tableFooterView, sideEffect: { $0.tableFooterView = $1 }).toAnyStyle
    }
}
