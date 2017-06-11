//
//  UICollectionViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UICollectionViewStyle<T: UICollectionView>: HashableConcreteStyle {
    @available(iOS 10.0, *)
    case isPrefetchingEnabled(Bool)
    case allowsSelection(Bool)
    case allowsMultipleSelection(Bool)
    case remembersLastFocusedIndexPath(Bool)
    case collectionViewLayout(UICollectionViewLayout)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .isPrefetchingEnabled(value):
            if #available(iOSApplicationExtension 10.0, *) {
                view.isPrefetchingEnabled = value
            }
        case let .allowsSelection(value):
            view.allowsSelection = value
        case let .allowsMultipleSelection(value):
            view.allowsMultipleSelection = value
        case let .remembersLastFocusedIndexPath(value):
            view.remembersLastFocusedIndexPath = value
        case let .collectionViewLayout(value):
            view.collectionViewLayout = value
        }
    }
    
    public static func == (lhs: UICollectionViewStyle<T>, rhs: UICollectionViewStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.isPrefetchingEnabled(left), .isPrefetchingEnabled(right)),
             let (.allowsSelection(left), .allowsSelection(right)),
             let (.allowsMultipleSelection(left), .allowsMultipleSelection(right)),
             let (.remembersLastFocusedIndexPath(left), .remembersLastFocusedIndexPath(right)):
            return left == right
        case let (.collectionViewLayout(left), .collectionViewLayout(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) static func startIndex() -> Int {
        return TableViewCellStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 5
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .isPrefetchingEnabled(value):
            return (1, value.hashValue)
        case let .allowsSelection(value):
            return (2, value.hashValue)
        case let .allowsMultipleSelection(value):
            return (3, value.hashValue)
        case let .remembersLastFocusedIndexPath(value):
            return (4, value.hashValue)
        case let .collectionViewLayout(value):
            return (5, value.hashValue)
        }
    }
}

public extension Component where T: UICollectionView {
    public func collectionView(_ styles: UICollectionViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
