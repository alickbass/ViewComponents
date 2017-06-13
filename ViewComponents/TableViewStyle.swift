//
//  TableViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum TableViewStyleKey: Int, Hashable {
    case rowHeight = 113, separatorStyle, separatorColor
    case separatorEffect, separatorInset, cellLayoutMarginsFollowReadableWidth
    case sectionHeaderHeight, sectionFooterHeight, estimatedRowHeight
    case estimatedSectionHeaderHeight, estimatedSectionFooterHeight, allowsSelection
    case allowsMultipleSelection, allowsSelectionDuringEditing, allowsMultipleSelectionDuringEditing
    case isEditing, sectionIndexColor, sectionIndexBackgroundColor
    case sectionIndexTrackingBackgroundColor, remembersLastFocusedIndexPath, dataSource
    case delegate
}

public enum TableViewStyle<T: UITableView>: KeyedStyle {
    public typealias Key = TableViewStyleKey
    
    case rowHeight(CGFloat)
    case separatorStyle(UITableViewCellSeparatorStyle)
    case separatorColor(UIColor?)
    case separatorEffect(UIVisualEffect?)
    case separatorInset(UIEdgeInsets)
    case cellLayoutMarginsFollowReadableWidth(Bool)
    case sectionHeaderHeight(CGFloat)
    case sectionFooterHeight(CGFloat)
    case estimatedRowHeight(CGFloat)
    case estimatedSectionHeaderHeight(CGFloat)
    case estimatedSectionFooterHeight(CGFloat)
    case allowsSelection(Bool)
    case allowsMultipleSelection(Bool)
    case allowsSelectionDuringEditing(Bool)
    case allowsMultipleSelectionDuringEditing(Bool)
    case isEditing(Bool)
    case sectionIndexColor(UIColor?)
    case sectionIndexBackgroundColor(UIColor?)
    case sectionIndexTrackingBackgroundColor(UIColor?)
    case remembersLastFocusedIndexPath(Bool)
    case dataSource(UITableViewDataSource?)
    case delegate(UITableViewDelegate?)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .rowHeight(value):
            view.rowHeight = value
        case let .separatorStyle(value):
            view.separatorStyle = value
        case let .separatorColor(value):
            view.separatorColor = value
        case let .separatorEffect(value):
            view.separatorEffect = value
        case let .separatorInset(value):
            view.separatorInset = value
        case let .cellLayoutMarginsFollowReadableWidth(value):
            view.cellLayoutMarginsFollowReadableWidth = value
        case let .sectionHeaderHeight(value):
            view.sectionHeaderHeight = value
        case let .sectionFooterHeight(value):
            view.sectionFooterHeight = value
        case let .estimatedRowHeight(value):
            view.estimatedRowHeight = value
        case let .estimatedSectionHeaderHeight(value):
            view.estimatedSectionHeaderHeight = value
        case let .estimatedSectionFooterHeight(value):
            view.estimatedSectionFooterHeight = value
        case let .allowsSelection(value):
            view.allowsSelection = value
        case let .allowsMultipleSelection(value):
            view.allowsMultipleSelection = value
        case let .allowsSelectionDuringEditing(value):
            view.allowsSelectionDuringEditing = value
        case let .allowsMultipleSelectionDuringEditing(value):
            view.allowsMultipleSelectionDuringEditing = value
        case let .isEditing(value):
            view.isEditing = value
        case let .sectionIndexColor(value):
            view.sectionIndexColor = value
        case let .sectionIndexBackgroundColor(value):
            view.sectionIndexBackgroundColor = value
        case let .sectionIndexTrackingBackgroundColor(value):
            view.sectionIndexTrackingBackgroundColor = value
        case let .remembersLastFocusedIndexPath(value):
            view.remembersLastFocusedIndexPath = value
        case let .dataSource(dataSource):
            view.dataSource = dataSource
        case let .delegate(delegate):
            view.delegate = delegate
        }
    }
    
    public static func == (lhs: TableViewStyle<T>, rhs: TableViewStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.rowHeight(left), .rowHeight(right)),
             let (.sectionHeaderHeight(left), .sectionHeaderHeight(right)),
             let (.sectionFooterHeight(left), .sectionFooterHeight(right)),
             let (.estimatedRowHeight(left), .estimatedRowHeight(right)),
             let (.estimatedSectionHeaderHeight(left), .estimatedSectionHeaderHeight(right)),
             let (.estimatedSectionFooterHeight(left), .estimatedSectionFooterHeight(right)):
            return left == right
        case let (.separatorStyle(left), .separatorStyle(right)):
            return left == right
        case let (.separatorColor(left), .separatorColor(right)),
             let (.sectionIndexColor(left), .sectionIndexColor(right)),
             let (.sectionIndexBackgroundColor(left), .sectionIndexBackgroundColor(right)),
             let (.sectionIndexTrackingBackgroundColor(left), .sectionIndexTrackingBackgroundColor(right)):
            return left == right
        case let (.separatorEffect(left), .separatorEffect(right)):
            return left == right
        case let (.separatorInset(left), .separatorInset(right)):
            return left == right
        case let (.cellLayoutMarginsFollowReadableWidth(left), .cellLayoutMarginsFollowReadableWidth(right)),
             let (.allowsSelection(left), .allowsSelection(right)),
             let (.allowsMultipleSelection(left), .allowsMultipleSelection(right)),
             let (.allowsSelectionDuringEditing(left), .allowsSelectionDuringEditing(right)),
             let (.allowsMultipleSelectionDuringEditing(left), .allowsMultipleSelectionDuringEditing(right)),
             let (.isEditing(left), .isEditing(right)),
             let (.remembersLastFocusedIndexPath(left), .remembersLastFocusedIndexPath(right)):
            return left == right
        case let (.dataSource(left), .dataSource(right)):
            return left === right
        case let (.delegate(left), .delegate(right)):
            return left === right
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .rowHeight(value):
            return (.rowHeight, value.hashValue)
        case let .separatorStyle(value):
            return (.separatorStyle, value.hashValue)
        case let .separatorColor(value):
            return (.separatorColor, value?.hashValue ?? 0)
        case let .separatorEffect(value):
            return (.separatorEffect, value?.hashValue ?? 0)
        case let .separatorInset(value):
            return (.separatorInset, value.hashValue)
        case let .cellLayoutMarginsFollowReadableWidth(value):
            return (.cellLayoutMarginsFollowReadableWidth, value.hashValue)
        case let .sectionHeaderHeight(value):
            return (.sectionHeaderHeight, value.hashValue)
        case let .sectionFooterHeight(value):
            return (.sectionFooterHeight, value.hashValue)
        case let .estimatedRowHeight(value):
            return (.estimatedRowHeight, value.hashValue)
        case let .estimatedSectionHeaderHeight(value):
            return (.estimatedSectionHeaderHeight, value.hashValue)
        case let .estimatedSectionFooterHeight(value):
            return (.estimatedSectionFooterHeight, value.hashValue)
        case let .allowsSelection(value):
            return (.allowsSelection, value.hashValue)
        case let .allowsMultipleSelection(value):
            return (.allowsMultipleSelection, value.hashValue)
        case let .allowsSelectionDuringEditing(value):
            return (.allowsSelectionDuringEditing, value.hashValue)
        case let .allowsMultipleSelectionDuringEditing(value):
            return (.allowsMultipleSelectionDuringEditing, value.hashValue)
        case let .isEditing(value):
            return (.isEditing, value.hashValue)
        case let .sectionIndexColor(value):
            return (.sectionIndexColor, value?.hashValue ?? 0)
        case let .sectionIndexBackgroundColor(value):
            return (.sectionIndexBackgroundColor, value?.hashValue ?? 0)
        case let .sectionIndexTrackingBackgroundColor(value):
            return (.sectionIndexTrackingBackgroundColor, value?.hashValue ?? 0)
        case let .remembersLastFocusedIndexPath(value):
            return (.remembersLastFocusedIndexPath, value.hashValue)
        case let .dataSource(value):
            return (.dataSource, value?.hash ?? 0)
        case let .delegate(value):
            return (.delegate, value?.hash ?? 0)
        }
    }
}

public extension Component where T: UITableView {
    public func tableView(_ styles: TableViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
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
}
