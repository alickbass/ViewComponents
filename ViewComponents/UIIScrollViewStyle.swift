//
//  UIIScrollViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIScrollViewStyleKey: Int, Hashable {
    case contentOffset = 85, contentSize, contentInset
    case isScrollEnabled, isDirectionalLockEnabled, isPagingEnabled
    case bounces, alwaysBounceVertical, alwaysBounceHorizontal
    case canCancelContentTouches, delaysContentTouches, indicatorStyle
    case scrollIndicatorInsets, showsHorizontalScrollIndicator, showsVerticalScrollIndicator
    case maximumZoomScale, minimumZoomScale, bouncesZoom
}

public enum UIScrollViewStyle<T: UIScrollView>: KeyedStyle {
    public typealias Key = UIScrollViewStyleKey
    
    case contentOffset(CGPoint)
    case contentSize(CGSize)
    case contentInset(UIEdgeInsets)
    case isScrollEnabled(Bool)
    case isDirectionalLockEnabled(Bool)
    case isPagingEnabled(Bool)
    case bounces(Bool)
    case alwaysBounceVertical(Bool)
    case alwaysBounceHorizontal(Bool)
    case canCancelContentTouches(Bool)
    case delaysContentTouches(Bool)
    case indicatorStyle(UIScrollViewIndicatorStyle)
    case scrollIndicatorInsets(UIEdgeInsets)
    case showsHorizontalScrollIndicator(Bool)
    case showsVerticalScrollIndicator(Bool)
    case maximumZoomScale(CGFloat)
    case minimumZoomScale(CGFloat)
    case bouncesZoom(Bool)

    public func sideEffect(on view: T) {
        switch self {
        case let .contentOffset(value):
            view.contentOffset = value
        case let .contentSize(value):
            view.contentSize = value
        case let .contentInset(value):
            view.contentInset = value
        case let .isScrollEnabled(value):
            view.isScrollEnabled = value
        case let .isDirectionalLockEnabled(value):
            view.isDirectionalLockEnabled = value
        case let .isPagingEnabled(value):
            view.isPagingEnabled = value
        case let .bounces(value):
            view.bounces = value
        case let .alwaysBounceVertical(value):
            view.alwaysBounceVertical = value
        case let .alwaysBounceHorizontal(value):
            view.alwaysBounceHorizontal = value
        case let .canCancelContentTouches(value):
            view.canCancelContentTouches = value
        case let .delaysContentTouches(value):
            view.delaysContentTouches = value
        case let .indicatorStyle(value):
            view.indicatorStyle = value
        case let .scrollIndicatorInsets(value):
            view.scrollIndicatorInsets = value
        case let .showsHorizontalScrollIndicator(value):
            view.showsHorizontalScrollIndicator = value
        case let .showsVerticalScrollIndicator(value):
            view.showsVerticalScrollIndicator = value
        case let .maximumZoomScale(value):
            view.maximumZoomScale = value
        case let .minimumZoomScale(value):
            view.minimumZoomScale = value
        case let .bouncesZoom(value):
            view.bouncesZoom = value
        }
    }
    
    public static func == (lhs: UIScrollViewStyle<T>, rhs: UIScrollViewStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.contentOffset(left), .contentOffset(right)):
            return left == right
        case let (.contentSize(left), .contentSize(right)):
            return left == right
        case let (.contentInset(left), .contentInset(right)),
             let (.scrollIndicatorInsets(left), .scrollIndicatorInsets(right)):
            return left == right
        case let (.isScrollEnabled(left), .isScrollEnabled(right)),
             let (.isDirectionalLockEnabled(left), .isDirectionalLockEnabled(right)),
             let (.isPagingEnabled(left), .isPagingEnabled(right)),
             let (.bounces(left), .bounces(right)),
             let (.alwaysBounceVertical(left), .alwaysBounceVertical(right)),
             let (.alwaysBounceHorizontal(left), .alwaysBounceHorizontal(right)),
             let (.canCancelContentTouches(left), .canCancelContentTouches(right)),
             let (.delaysContentTouches(left), .delaysContentTouches(right)),
             let (.showsHorizontalScrollIndicator(left), .showsHorizontalScrollIndicator(right)),
             let (.showsVerticalScrollIndicator(left), .showsVerticalScrollIndicator(right)),
             let (.bouncesZoom(left), .bouncesZoom(right)):
            return left == right
        case let (.maximumZoomScale(left), .maximumZoomScale(right)),
             let (.minimumZoomScale(left), .minimumZoomScale(right)):
            return left == right
        case let (.indicatorStyle(left), .indicatorStyle(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .contentOffset(value):
            return (.contentOffset, value.hashValue)
        case let .contentSize(value):
            return (.contentSize, value.hashValue)
        case let .contentInset(value):
            return (.contentInset, value.hashValue)
        case let .isScrollEnabled(value):
            return (.isScrollEnabled, value.hashValue)
        case let .isDirectionalLockEnabled(value):
            return (.isDirectionalLockEnabled, value.hashValue)
        case let .isPagingEnabled(value):
            return (.isPagingEnabled, value.hashValue)
        case let .bounces(value):
            return (.bounces, value.hashValue)
        case let .alwaysBounceVertical(value):
            return (.alwaysBounceVertical, value.hashValue)
        case let .alwaysBounceHorizontal(value):
            return (.alwaysBounceHorizontal, value.hashValue)
        case let .canCancelContentTouches(value):
            return (.canCancelContentTouches, value.hashValue)
        case let .delaysContentTouches(value):
            return (.delaysContentTouches, value.hashValue)
        case let .indicatorStyle(value):
            return (.indicatorStyle, value.hashValue)
        case let .scrollIndicatorInsets(value):
            return (.scrollIndicatorInsets, value.hashValue)
        case let .showsHorizontalScrollIndicator(value):
            return (.showsHorizontalScrollIndicator, value.hashValue)
        case let .showsVerticalScrollIndicator(value):
            return (.showsVerticalScrollIndicator, value.hashValue)
        case let .maximumZoomScale(value):
            return (.maximumZoomScale, value.hashValue)
        case let .minimumZoomScale(value):
            return (.minimumZoomScale, value.hashValue)
        case let .bouncesZoom(value):
            return (.bouncesZoom, value.hashValue)
        }
    }
}

public extension Component where T: UIScrollView {
    public func scrollView(_ styles: UIScrollViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
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
