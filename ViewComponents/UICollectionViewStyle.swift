//
//  UICollectionViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UICollectionViewStyleKey: Int, Hashable {
    case isPrefetchingEnabled = 147, allowsSelection, allowsMultipleSelection
    case remembersLastFocusedIndexPath, collectionViewLayout
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
