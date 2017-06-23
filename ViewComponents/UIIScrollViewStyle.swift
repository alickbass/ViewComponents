//
//  UIIScrollViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UIScrollViewStyleKey: Int, StyleKey {
    case contentOffset = 300, contentSize, contentInset
    case isScrollEnabled, isDirectionalLockEnabled, isPagingEnabled
    case bounces, alwaysBounceVertical, alwaysBounceHorizontal
    case canCancelContentTouches, delaysContentTouches, indicatorStyle
    case scrollIndicatorInsets, showsHorizontalScrollIndicator, showsVerticalScrollIndicator
    case maximumZoomScale, minimumZoomScale, bouncesZoom
}

public extension AnyStyle where T: UIScrollView {
    private typealias ViewStyle<Item> = Style<T, Item, UIScrollViewStyleKey>
    
    public static func contentOffset(_ value: CGPoint) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentOffset, sideEffect: { $0.contentOffset = $1 }).toAnyStyle
    }
    
    public static func contentSize(_ value: CGSize) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentSize, sideEffect: { $0.contentSize = $1 }).toAnyStyle
    }
    
    public static func contentInset(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentInset, sideEffect: { $0.contentInset = $1 }).toAnyStyle
    }
    
    public static func isScrollEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isScrollEnabled, sideEffect: { $0.isScrollEnabled = $1 }).toAnyStyle
    }
    
    public static func isDirectionalLockEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isDirectionalLockEnabled, sideEffect: { $0.isDirectionalLockEnabled = $1 }).toAnyStyle
    }
    
    public static func isPagingEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isPagingEnabled, sideEffect: { $0.isPagingEnabled = $1 }).toAnyStyle
    }
    
    public static func bounces(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .bounces, sideEffect: { $0.bounces = $1 }).toAnyStyle
    }
    
    public static func alwaysBounceVertical(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .alwaysBounceVertical, sideEffect: { $0.alwaysBounceVertical = $1 }).toAnyStyle
    }
    
    public static func alwaysBounceHorizontal(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .alwaysBounceHorizontal, sideEffect: { $0.alwaysBounceHorizontal = $1 }).toAnyStyle
    }
    
    public static func canCancelContentTouches(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .canCancelContentTouches, sideEffect: { $0.canCancelContentTouches = $1 }).toAnyStyle
    }
    
    public static func delaysContentTouches(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .delaysContentTouches, sideEffect: { $0.delaysContentTouches = $1 }).toAnyStyle
    }
    
    public static func indicatorStyle(_ value: UIScrollViewIndicatorStyle) -> AnyStyle<T> {
        return ViewStyle(value, key: .indicatorStyle, sideEffect: { $0.indicatorStyle = $1 }).toAnyStyle
    }
    
    public static func scrollIndicatorInsets(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .scrollIndicatorInsets, sideEffect: { $0.scrollIndicatorInsets = $1 }).toAnyStyle
    }
    
    public static func showsHorizontalScrollIndicator(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .showsHorizontalScrollIndicator, sideEffect: { $0.showsHorizontalScrollIndicator = $1 }).toAnyStyle
    }
    
    public static func showsVerticalScrollIndicator(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .showsVerticalScrollIndicator, sideEffect: { $0.showsVerticalScrollIndicator = $1 }).toAnyStyle
    }
    
    public static func maximumZoomScale(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .maximumZoomScale, sideEffect: { $0.maximumZoomScale = $1 }).toAnyStyle
    }
    
    public static func minimumZoomScale(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .minimumZoomScale, sideEffect: { $0.minimumZoomScale = $1 }).toAnyStyle
    }
    
    public static func bouncesZoom(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .bouncesZoom, sideEffect: { $0.bouncesZoom = $1 }).toAnyStyle
    }
}
