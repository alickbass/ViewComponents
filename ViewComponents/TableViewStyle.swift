//
//  TableViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum TableViewStyle<T: UITableView>: HashableConcreteStyle {
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
    
    @inline(__always) static func startIndex() -> Int {
        return 113
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 22
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .rowHeight(value):
            return (1, value.hashValue)
        case let .separatorStyle(value):
            return (2, value.hashValue)
        case let .separatorColor(value):
            return (3, value?.hashValue ?? 0)
        case let .separatorEffect(value):
            return (4, value?.hashValue ?? 0)
        case let .separatorInset(value):
            return (5, value.hashValue)
        case let .cellLayoutMarginsFollowReadableWidth(value):
            return (6, value.hashValue)
        case let .sectionHeaderHeight(value):
            return (7, value.hashValue)
        case let .sectionFooterHeight(value):
            return (8, value.hashValue)
        case let .estimatedRowHeight(value):
            return (9, value.hashValue)
        case let .estimatedSectionHeaderHeight(value):
            return (10, value.hashValue)
        case let .estimatedSectionFooterHeight(value):
            return (11, value.hashValue)
        case let .allowsSelection(value):
            return (12, value.hashValue)
        case let .allowsMultipleSelection(value):
            return (13, value.hashValue)
        case let .allowsSelectionDuringEditing(value):
            return (14, value.hashValue)
        case let .allowsMultipleSelectionDuringEditing(value):
            return (15, value.hashValue)
        case let .isEditing(value):
            return (16, value.hashValue)
        case let .sectionIndexColor(value):
            return (17, value?.hashValue ?? 0)
        case let .sectionIndexBackgroundColor(value):
            return (18, value?.hashValue ?? 0)
        case let .sectionIndexTrackingBackgroundColor(value):
            return (19, value?.hashValue ?? 0)
        case let .remembersLastFocusedIndexPath(value):
            return (20, value.hashValue)
        case let .dataSource(value):
            return (21, value?.hash ?? 0)
        case let .delegate(value):
            return (22, value?.hash ?? 0)
        }
    }
}

public extension Component where T: UITableView {
    public func tableView(_ styles: TableViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
