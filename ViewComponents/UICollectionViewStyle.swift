//
//  UICollectionViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UICollectionViewStyleKey: Int, Hashable {
    case isPrefetchingEnabled = 147, allowsSelection, allowsMultipleSelection
    case remembersLastFocusedIndexPath, collectionViewLayout
}

public enum UICollectionViewStyle<T: UICollectionView>: KeyedStyle {
    public typealias Key = UICollectionViewStyleKey
    
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
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .isPrefetchingEnabled(value):
            return (.isPrefetchingEnabled, value.hashValue)
        case let .allowsSelection(value):
            return (.allowsSelection, value.hashValue)
        case let .allowsMultipleSelection(value):
            return (.allowsMultipleSelection, value.hashValue)
        case let .remembersLastFocusedIndexPath(value):
            return (.remembersLastFocusedIndexPath, value.hashValue)
        case let .collectionViewLayout(value):
            return (.collectionViewLayout, value.hashValue)
        }
    }
}

public extension Component where T: UICollectionView {
    public func collectionView(_ styles: UICollectionViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}

public extension AnyStyle where T: UICollectionView {
    private typealias ViewStyle<Item> = Style<T, Item, UICollectionViewStyleKey>
    
    @available(iOS 10.0, *)
    public static func isPrefetchingEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isPrefetchingEnabled, sideEffect: { $0.isPrefetchingEnabled = $1 }).toAnyStyle
    }
    
    public static func allowsSelection(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsSelection, sideEffect: { $0.allowsSelection = $1 }).toAnyStyle
    }
    
    public static func allowsMultipleSelection(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsMultipleSelection, sideEffect: { $0.allowsMultipleSelection = $1 }).toAnyStyle
    }
    
    public static func remembersLastFocusedIndexPath(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .remembersLastFocusedIndexPath, sideEffect: { $0.remembersLastFocusedIndexPath = $1 }).toAnyStyle
    }
    
    public static func collectionViewLayout(_ value: UICollectionViewLayout) -> AnyStyle<T> {
        return ViewStyle(value, key: .collectionViewLayout, sideEffect: { $0.collectionViewLayout = $1 }).toAnyStyle
    }
}
